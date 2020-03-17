class Api::V1::OrdenatedOrderProductSerializer < ActiveModel::Serializer
  attributes :id, :order_id, :product, :layer, :quantity, :ballast

  def product
    object.product.label
  end

  def ballast
    object.product.ballast
  end
end
