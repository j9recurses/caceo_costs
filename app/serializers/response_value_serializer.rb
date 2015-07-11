class ResponseValueSerializer < ActiveModel::Serializer
  attributes :id, :value, :data_type, :field, :na_value
  belongs_to :survey_response
  belongs_to :question

  def field
    object.question.field
  end

  def data_type
    object.question.data_type
  end
end
