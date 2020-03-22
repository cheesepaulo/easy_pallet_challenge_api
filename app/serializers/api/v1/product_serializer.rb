class Api::V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :label, :ballast
end