module ResponseAttributable
  include Virtus.model

  def self.included(klass) do |klass|
    survey = Survey.find klass
    survey.questions.select(:field, :data_type).each do |q|
      attribute q.field, q.data_type.titleize.constantize
    end
  end
end

class ResponseForm
  include ActiveModel::Model
  include Virtus.model
  include ResponseAttributable

  attribute :county_id, Integer
  attribute :election_id, Integer
  attribute :survey_id, Integer
  # attribute :response_id, 

  # def initialize(survey)
  #   @survey = survey.include(NotApplicable).include(ResponseValidatable)
  # end

  # def initialize(survey_response)
  #   @survey_response = survey_response
  # end
  # attr_accessor :survey_response

  # def survey_response
  #   @survey_response ||= SurveyResponse.find_or_
  # end

  def questions

  end

private
  def persist!
    @survey_response = SurveyResponse.where(county_id: county_id, election_id: election_id, survey_id: survey_id).first_or_create!
    @survey_response.question
  end
end