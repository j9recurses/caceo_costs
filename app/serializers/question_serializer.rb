class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :name
  def name
    object.label
  end
end
