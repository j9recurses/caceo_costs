class SurveyPresenter
  extend Forwardable

  def initialize(survey, template)
    @survey = survey
    @template = template
  end
  attr_reader :survey, :template

  survey_section_methods = []
  GeneralSurvey::SURVEY_SECTIONS.each do |section|
    survey_section_methods.concat ["#{section}_items".to_sym, "#{section}_total".to_sym]
  end

  def method_missing(name, *args)
    if @survey.respond_to?(name)
      @survey.send(name, *args)
    else
      super
    end
  end

  def as_percent( value )
    if value.is_a?(Numeric)
      "#{template.number_with_delimiter value}%"
    else
      value
    end
  end

  def as_dollars( value )
    if value.is_a?(Numeric)
      "$#{template.number_with_delimiter value}"
    else
      value
    end
  end

  def delimited( value )
    "#{template.number_with_delimiter value}"
  end
  
  def form_pages
    @form_pages ||= if survey.election_profile?
      survey.form.to_a.compact.in_groups_of(16, false)
    else
      survey.form.to_a.compact.in_groups_of(12, false)
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