class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :load_id, :code, :bay
  has_many :order_products, serializer: Api::V1::OrderProductSerializer
end
