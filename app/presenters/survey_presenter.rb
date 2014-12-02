class SurveyPresenter
  extend Forwardable

  def initialize(survey, template)
    @survey = survey
    @template = template
  end
  attr_reader :survey

  survey_section_methods = []
  GeneralSurvey::SURVEY_SECTIONS.each do |section|
    survey_section_methods.concat ["#{section}_items".to_sym, "#{section}_total".to_sym]
  end

  def_delegators :@survey, :form, :data, :election
  def_delegators :@survey, *survey_section_methods, :response_for

  def method_missing(name, *args)
    if @survey.respond_to?(name)
      @survey.send(name, *args)
    else
      super
    end
  end

  def current_step
    survey.data.current_step
  end

  def first_step? 
    survey.data.first_step?
  end

  def last_step?
    survey.data.last_step?
  end

  def total_steps
    survey.data.total_steps
  end

  def form_pages
    @form_pages ||= survey.form.compact.in_groups_of(12)
  end

  def survey_name
    @survey_name ||= survey.form.pluck(:name).first.titleize
  end

  def title_show
    "#{survey_name.gsub('Salaries Related To', '')} Salaries Summary for the"
  end

  def cost_type
    if survey.salary?
      'salaries'
    elsif survey.service_supply?
      'services_supplies'
    end
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