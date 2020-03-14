class Api::V1::LoadDetailSerializer < ActiveModel::Serializer
  attributes :id, :code, :delivery_date
  has_many :orders
end
