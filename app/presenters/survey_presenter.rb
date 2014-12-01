class SurveyPresenter
  extend Forwardable

  def initialize(survey_form, survey_data, template)
    @survey = GeneralSurvey.new(survey_data)
    @template = template
  end

  def_delegators :@survey, :form, :data, :current_step, :total_steps, :first_step?, :last_step?

  def form_pages
    @form_pages ||= survey.form.compact.in_groups_of(12)
  end

  def survey_name
    @survey_name ||= survey.form.pluck(:name).first.titleize
  end

  def title_show
    "#{survey_name.gsub('Salaries Related To', '')} Salaries Summary for the"
  end

  def header_text
    if survey.salary?
      header_item = "for the"
    elsif survey.service_supply?
      header_item = "Costs for the"
    end
    header_item
  end
end