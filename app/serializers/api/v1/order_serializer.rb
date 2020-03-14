class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :load_id, :code, :bay
  has_many :order_products
end
