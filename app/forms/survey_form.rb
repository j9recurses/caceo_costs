class SurveyForm

  def initialize(survey)
    @survey = survey.include(NotApplicable).include(ResponseValidatable)
  end
end