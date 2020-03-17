class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :load_id, :code, :bay, :organized
  has_many :order_products, serializer: Api::V1::OrderProductSerializer

  def organized
    object.ordenated_order_products.present?
  end
end
