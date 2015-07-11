class QuestionSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :survey
end
