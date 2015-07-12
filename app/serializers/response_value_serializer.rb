class ResponseValueSerializer < ActiveModel::Serializer
  attributes :id, :value, :data_type, :na_value
  belongs_to :question

  def data_type
    object.question.data_type
  end
end
