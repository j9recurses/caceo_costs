# class String
#   def numeric?
#     Float(self) != nil rescue false
#   end
# end

class SurveyPresenter
  extend Forwardable

  def initialize(survey_form, survey_data, template)
    @survey_form = survey_form
    @survey_data = survey_data
    @template = template
  end

  def_delegators :@survey_data, :current_step, :total_steps, :first_step?, :last_step?

  SURVEY_SHOW_SECTIONS = %w{ salary_estimate benefits_percent benefits_dollar hours comment salary service_supply election_profile }

  SURVEY_SHOW_SECTIONS.each do |name|
    define_method("#{name}_items") do
      show_item_lists[name] ||= []
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

  def comments_filter
    @comments_filter ||= FilterCost.find_by(filtertype: "comment").fieldlist
  end

  def klass
    @survey_data.class
  end

  def show_item_lists
    @survey_show_item_lists ||= {}
  end

  def title_show
    "#{survey_name.gsub('Salaries Related To', '')} Salaries Summary for the"
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
    @survey_form.each do |item|
      # item_value = @survey_data[ item.field ]
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
    @survey_form.each do |item|
      if comments_filter.include?(item.field)
        comment_items.push item
      else
        service_supply_items.push item
      end
    end
  end

  def sort_election_profile
    @survey_form.each do |item|
      election_profile_items.push item
    end
  end

  def election_profile?
    @survey_form.pluck(:model_name).first == "election_profiles"
  end
  
  def response_for( item, numeric_dollars: false )
    match = /(ssbalpri|eplang)(\w+)ml/.match item.field
    value = @survey_data[ item.field ]

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

  def salary_estimate_benefits_total
    benefits_dollar_total + salary_estimate_total
  end

  def salary_benefits_total
    benefits_dollar_total + salary_total
  end

  def data
    @survey_data
  end

  def form
    @survey_form
  end

  def form_pages
    @form_pages ||= form.compact.in_groups_of(12)
  end

  def survey_name
    @survey_name ||= @survey_form.pluck(:name).first.titleize
  end

  def cost_type
    @survey_form.pluck(:cost_type).uniq.first
  end

  def header_text
    if cost_type == 'salaries'
      header_item = "for the"
    elsif cost_type == 'services & supplies'
      header_item = "Costs for the"
    end
    header_item
  end
end