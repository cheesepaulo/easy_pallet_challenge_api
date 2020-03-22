class Api::V1::OrderProductsController < Api::V1::BaseController
  before_action :set_order, only: [:create, :index]
  before_action :set_order_product, except: [:index, :create]

  def index
    @order_products = @order.order_products
    render json: @order_products
  end

  def create
    @order_product = @order.order_products.build(order_product_params)

    if @order_product.save
      destroy_ordenated_order_products

      render json: @order_product, status: :created
    else
      render json: { errors: @order_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @order_product.update(order_product_params)
      destroy_ordenated_order_products

      render json: @order_product, status: :created
    else
      render json: { errors: @order_product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @order_product.destroy
    destroy_ordenated_order_products
    render status: :ok
  end

  private

  def destroy_ordenated_order_products
    @order_product.order.ordenated_order_products.destroy_all
  end

  def set_order_product
    @order_product = OrderProduct.find_by!(id: params[:id])
  end

  def set_order
    @order = Order.find_by!(id: params[:order_id])
  end

  def order_product_params
    params.require(:order_product).permit(:product_id, :quantity)
  end
end