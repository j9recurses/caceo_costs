class SurveyPresenter
  extend Forwardable

  def initialize(survey_form, survey_data, template)
    @survey_form = survey_form
    @survey_data = survey_data
    @template = template
  end

  def_delegators :@survey_data, :current_step, :total_steps, :first_step?, :last_step?

  SURVEY_SHOW_SECTIONS = %w{ salary_estimate benefits_percent benefits_dollar hours comment salary service_supply }

  SURVEY_SHOW_SECTIONS.each do |name|
    define_method("#{name}_items") do
      show_item_lists[name] ||= {}
    end

    define_method("#{name}_total") do
      self.send("#{name}_items").values.compact.inject { |sum, item_value| sum + item_value }
    end
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
    if cost_type == 'salaries'
      sort_salaries
    elsif cost_type == 'services & supplies'
      sort_services_supplies
    end
  end

  def sort_salaries
    @survey_form.each do |item|
      item_value = @survey_data[ item.field ]
      case item.label
      when /Salaries/
        salary_estimate_items[item.label] = item_value.nil? ? 0 : item_value
      when /Benefits.*percent/
        benefits_percent_items[item.label] = item_value.nil? ? 0 : item_value
      when /Benefits.*dollars/
        benefits_dollar_items[item.label] = item_value.nil? ? 0 : item_value
      when /Hours/
        hours_items[item.label] = item_value.nil? ? 0 : item_value
      when /General/
        comment_items[item.label] = item_value
      else
        salary_items[item.label] = item_value.nil? ? 0 : item_value
      end
    end
  end

  def sort_services_supplies
    @survey_form.each do |item|
      item_value = @survey_data[ item.field ]
      if FilterCost.find_by(filtertype: "comment").fieldlist.include?(item.field)
        comment_items[item.label] = item_value
      else
        service_supply_items[item.label] = item_value.nil? ? 0 : item_value
      end
    end
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