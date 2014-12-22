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

  def form_pages
    @form_pages ||= if survey.election_profile?
      survey.form.compact.in_groups_of(16)
    else
      survey.form.compact.in_groups_of(12)
    end
  end

  def title_show
    "#{survey.title.gsub('Salaries Related To', '')} #{'Salaries' if survey.salary?} Summary for the"
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