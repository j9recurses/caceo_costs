class SurveyResponseSerializer < ActiveModel::Serializer
  attributes :id, :total
  belongs_to :county
  belongs_to :election, serializer: ElectionSerializer
end
