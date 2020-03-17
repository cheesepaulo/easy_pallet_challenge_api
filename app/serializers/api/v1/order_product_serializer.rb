class Api::V1::OrderProductSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :product_id, :product_label, :quantity, :ballast

  def ballast
    object.product.ballast
  end

  def product_label
    object.product.label
  end
end
