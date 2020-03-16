class Api::V1::OrdersController < Api::V1::BaseController
  before_action :set_order

  def show
    render json: @order
  end

  def organize
    if @order.order_products.present?
      result = Api::V1::OrganizeOrderService.new(@order).call
      if result == true
        render json: "Order organized successful.", status: :created
      else
        render json: "This request could not be organized", status: :no_content
      end
    else
      render json: "It is not possible to organize an empty order", status: :no_content
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
