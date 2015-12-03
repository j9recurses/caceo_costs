class ResponsePersistor
  def initialize(response)
    @response = response
  end
  attr_accessor :response

  def submit
    survey_response = SurveyResponse.find_or_initialize_by(
      response: response, 
      county_id: response.county_id, 
      election_id: response.election_id
    )

    survey_response.valid? && survey_response.save
  end

  def destroy
    response.destroy
  end
end
