class Api::V1::OrdenatedOrderProductsController < Api::V1::BaseController
  before_action :set_order

  def index
    @ordenated_order_products = @order.ordenated_order_products
    render json: @ordenated_order_products
  end

  private

  def set_order
    @order = Order.find_by!(id: params[:order_id])
  end
end