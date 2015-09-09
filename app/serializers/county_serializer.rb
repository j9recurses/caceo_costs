class CountySerializer < ActiveModel::Serializer
  attributes :id, :name

  def id
    object.key
  end
end