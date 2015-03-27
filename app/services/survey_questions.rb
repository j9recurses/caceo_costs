class SurveyQuestions
  def initialize(survey_response)
    @response = survey_response
    @questions = Questions.where(survey: Survey.find_by( response_type: @response.class ) )
  end
  attr_accessor :response, :questions

  def find(question_field)
    questions.find_by(field: question_field)
  end
end