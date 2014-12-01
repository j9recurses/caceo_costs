class GeneralSurvey
  def initialize(survey_data)
    @data = survey_data
    form
  end

  def model_name
    @model_name ||= self.class.to_s.gsub('Controller', '').downcase
  end

  def model_singular
    @model_singular ||= model_name.singularize
  end

  def klass
    @klass ||= data.class
  end

  def form_klass
    @form_klass ||= election_profile? ? ElectionProfileDescription : CategoryDescription
  end

  def form
    @form ||= form_klass.where(model_name: model_name)
  end
  
  def election_profile?
    klass == ElectionProfile
  end

  def salary?
    klass.to_s.match /^Sal/
  end

  def service_supply?
    klass.to_s.match /^(Ss|Postage)/
  end

  SURVEY_SECTIONS = %w{ salary_estimate benefits_percent benefits_dollar hours comment salary service_supply election_profile }

  SURVEY_SECTIONS.each do |name|
    define_method("#{name}_items") do
      survey_item_lists[name] ||= []
    end

    define_method("#{name}_total") do
      self.send("#{name}_items").compact.inject(0) do |sum, item|    
        response = response_for( item )
        if response.is_a? Numeric
          sum + response
        else
          sum
        end
      end
    end
  end

  def service_supply_total
    self.service_supply_items.reject { |item| 
      item.field == 'ssbalpriprou'
    }.compact.inject(0) do |sum, item| 
      response = response_for( item )
      if response.is_a? Numeric
        sum + response
      else
        sum
      end
    end
  end

  def salary_estimate_benefits_total
    benefits_dollar_total + salary_estimate_total
  end

  def salary_benefits_total
    benefits_dollar_total + salary_total
  end

  def survey_total
    send("#{survey_type}_total")
  end

  def survey_type
    if election_profile?
      'election_profile'
    elsif salary?
      'salary'
    elsif service_supply?
      'service_supply'
    end
  end

  def comments_filter
    @comments_filter ||= FilterCost.find_by(filtertype: "comment").fieldlist
  end

  def survey_item_lists
    item_lists ||= {}
  end


  def sort_form_items
    if election_profile?
      sort_election_profile
    elsif cost_type == 'salaries'
      sort_salaries
    elsif cost_type == 'services & supplies'
      sort_services_supplies
    end
  end

  def sort_salaries
    form.each do |item|
      # item_value = data[ item.field ]
      case item.label
      when /Salaries/
        salary_estimate_items.push item
      when /Benefits.*percent/
        benefits_percent_items.push item
      when /Benefits.*dollars/
        benefits_dollar_items.push item
      when /Hours/
        hours_items.push item
      when /General/
        comment_items.push item
      else
        salary_items.push item
      end
    end
  end

  def sort_services_supplies
    form.each do |item|
      if comments_filter.include?(item.field)
        comment_items.push item
      else
        service_supply_items.push item
      end
    end
  end

  def sort_election_profile
    form.each do |item|
      election_profile_items.push item
    end
  end

  
  def response_for( item, numeric_dollars: false )
    match = /(ssbalpri|eplang)(\w+)ml/.match item.field
    value = survey_data[ item.field ]

    if match
      response = self.data.send("#{match[1]}#{match[2]}_multi_lang")
      if response.blank?
        response = 'No language selected'
      else
        response = response.join(', ')
      end
    elsif item.respond_to?(:fieldtype) # only ElectionProfileDescription
      if item.fieldtype == 'boolean'
        if value == true
          response = 'Yes'
        elsif value == false
          response = 'No'
        end
      elsif item.fieldtype == "string"
        response = value
      elsif item.fieldtype == "integer"
        response = value.nil? ? 0 : value
      end
    elsif comments_filter.include? item.field
      response = value
    else
      response = value.nil? ? 0 : value
    end

    if numeric_dollars && response.is_a?(Numeric)
      response = "$#{response}"
    end

    return response
  end
end