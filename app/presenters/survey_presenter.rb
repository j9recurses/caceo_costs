class SurveyPresenter
  extend Forwardable

  def initialize(survey_form, survey_data, template)
    @survey_form = survey_form
    @survey_data = survey_data
    @template = template
  end

  def_delegators :@survey_data, :current_step, :total_steps, :first_step?, :last_step?

  def title_show
    "#{survey_name.gsub('Salaries Related To', '')} Salaries Summary for the"
  end

  def benefit_percent_items
    @benefit_percent_items ||= @survey_form.find_all { |form_item|
      form_item.label =~ /Benefits.*percent/
    }.map do |form_item|

      item_label = form_item.label
      item_value = @survey_data[ item_label ]
      { item_label => item_label.nil? ? 0 : item_label }
    end
  end

  def benefit_percent_total
    benefit_percent_items.inject { |sum, item| sum + item. }
  end

  def benefit_dollar_items

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
    @cost_type ||= @survey_form.pluck(:cost_type).uniq
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