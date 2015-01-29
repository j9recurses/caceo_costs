class SurveyPersistor

  def initialize(survey)
    @survey = survey
  end
  attr_accessor :survey

  def survey_data
    survey.data
  end

  def save
    save_success = survey.data.save
    if survey.election_profile?
      election_success = true
    else
      election_success = survey.election.year_elements.find_or_create_by( element: survey_data )
    end
    save_success && election_success
  end

  def destroy
    survey_data.destroy
  end
end