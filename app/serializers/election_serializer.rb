class ElectionSerializer < ActiveModel::Serializer
  def name
    object.year
  end
  def id
    object.index
  end
  attributes :id, :name
end