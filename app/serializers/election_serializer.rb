class ElectionSerializer < ActiveModel::Serializer
  def id
    object.index
  end
  attributes :id, :name
end