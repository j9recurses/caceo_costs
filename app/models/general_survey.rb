class GeneralSurvey
  def initialize(survey_data)
    @data = survey_data
    form
    # sort_form_items # taken out when I put in xlsx reports, gen surv is widely used, don't need to sort except for totals
  end
  attr_reader :data, :form

  def model_name
    @model_name ||= "#{@data.class.to_s.underscore}s"
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
#######

####### class Survey
  def form
    @form ||= form_klass.where(model_name: model_name).where.not('label LIKE "%Percent%" AND model_name != "salbals"')
  end

  def count_questions
    @total_questions ||= form.count
  end

  def count_answers
    @total_responses ||= form.inject(0) do |sum, form_item|
      answered?( form_item ) ? sum + 1 : sum
    end
  end

  def answered?( form_item )
    !self.data[ form_item.field ].blank?
  end

  def completed_ratio
    (count_answers.to_f / count_questions.to_f).round(2)
  end

  def percent_complete
    (completed_ratio * 100).to_i
  end

  def category
    @category ||= Category.find_by(election_year_id: data.election_year_id, county: data.county,  model_name: "#{klass.to_s.underscore}s")
  end

  def election_profile?
    klass == ElectionProfile ? true : false
  end

  def salary?
    klass.to_s.match( /^Sal/ ) ? true : false
  end

  def service_supply?
    klass.to_s.match( /^(Ss|Postage)/ ) ? true : false
  end

  def election
    # if data.persisted?
      @election ||= if election_profile?
        ElectionYearProfile.find( data.election_year_profile_id )
      else
        ElectionYear.find( data.election_year_id )
      end
    # else
    #   nil
    # end
  end

  SURVEY_SECTIONS = %w{ salary_estimate benefits_percent benefits_dollar hours comment salary service_supply election_profile }

  SURVEY_SECTIONS.each do |name|
    define_method("#{name}_items") do
      survey_item_lists[name] ||= []
    end

    define_method("#{name}_total") do
      sort_form_items unless @sorted
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
    sort_form_items unless @sorted
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

  def total
    if salary?
      salary_estimate_benefits_total
    elsif service_supply?
      service_supply_total
    else
      nil
    end
  end

  def comments_filter
    @comments_filter ||= FilterCost.find_by(filtertype: "comment").fieldlist
  end

  def survey_item_lists
    @item_lists ||= {}
  end

  def sort_form_items
    if election_profile?
      sort_election_profile
    elsif salary?
      sort_salaries
    elsif service_supply?
      sort_services_supplies
    end
    @sorted = true
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

  def benefits_percent?
    benefits_percent_items.size > 0
  end
  
  def response_for( item, numeric_dollars: false, nil_zeros: true )
    match = /(ssbalpri|eplang)(\w+)ml/.match item.field
    value = self.data[ item.field ]

    if match
      response = self.data.send("#{match[1]}#{match[2]}_multi_lang")
      if response.blank?
        response = 'No language selected'
      else
        response = response.join(', ')
      end
    elsif item.respond_to?(:fieldtype) # only ElectionProfileDescription
      if item.fieldtype.chomp == 'boolean'
        if value == true
          response = 'Yes'
        elsif value == false
          response = 'No'
        end
      elsif item.fieldtype.chomp == "string"
        response = value
      elsif item.fieldtype.chomp == "integer"
        if value.nil?
          response = nil_zeros ? 0 : value
        else
          response = value
        end        
      end
    elsif comments_filter.include? item.field
      response = value
    else
      if value.nil?
        response = nil_zeros ? 0 : value
      else
        response = value
      end
      # response = value.nil? ? 0 : value
    end

    if numeric_dollars && response.is_a?(Numeric)
      response = "$#{response}"
    end

    return response
  end
end