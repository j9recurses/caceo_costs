class SurveySerializer < ActiveModel::Serializer
  def name
    object.title
  end
  attributes :id, :name
end