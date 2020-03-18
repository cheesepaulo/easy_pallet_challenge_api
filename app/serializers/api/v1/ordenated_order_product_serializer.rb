class Api::V1::OrdenatedOrderProductSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :product_label, :layer, :quantity, :ballast

  def product_label
    object.product.label
  end

  def ballast
    object.product.ballast
  end
end
