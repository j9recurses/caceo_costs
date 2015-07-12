class ElectionYearSerializer < ActiveModel::Serializer
  def name
    object.year
  end
  attributes :id, :name
end