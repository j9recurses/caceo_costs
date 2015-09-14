class DataSerializer < ActiveModel::Serializer
  attributes :county_id, :election_code, :survey_code, :question_code, :data_value

  def question_code
    object.question.field
  end

  def county_id
    object.survey_response.county_id
  end

  def election_code
    object.survey_response.election.code
  end

  def survey_code
    object.survey_response.response_type
  end
end