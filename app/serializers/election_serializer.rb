class ElectionSerializer < ActiveModel::Serializer
  def name
    object.year
  end
  attributes :id, :name
end