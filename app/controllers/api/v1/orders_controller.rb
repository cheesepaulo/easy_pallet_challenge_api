class Api::V1::OrdersController < Api::V1::BaseController
  before_action :set_order, except: [:create]
  before_action :set_load, only: [:create]

  def show
    render json: @order
  end

  def show_ordenated
    render json: @order.ordenated_order_products
  end

  def create
    @order = @load.orders.build(order_params)

    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def organize
    if order_can_be_organized?
      if Api::V1::OrganizeOrderService.new(@order).call == true
        render json: "Order organized successful.", status: :created
      else
        render json: "This request could not be organized.", status: :bad_request
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:code, :bay)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_load
    @load = Load.find(params[:load_id])
  end

  def order_can_be_organized?
    if @order.ordenated_order_products.present?
      render json: "It is not possible to organize an order already organized.", status: :bad_request
      return false
    elsif @order.order_products.present?
      return true
    else
      render json: "It is not possible to organize an empty order.", status: :bad_request
      return false
    end
  end
end
