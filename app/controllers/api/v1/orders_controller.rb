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

  def update
    if @order.update(order_params)
      render json: @order, status: :ok
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    unless @order.order_products.present? || @order.ordenated_order_products.present?
      @order.destroy
      render status: :ok
    else
      render json: "Não é possivel excluir uma gravata com items associados.", status: :unprocessable_entity
    end  
  end

  def organize
    if order_can_be_organized?
      if Api::V1::OrganizeOrderService.new(@order).call == true
        render json: "Gravata organizada com sucesso", status: :created
      else
        render json: "Esta gravata não pode ser organizada", status: :bad_request
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
      render json: "Não é possivel organizar uma gravata já organizada", status: :bad_request
      return false
    elsif @order.order_products.present?
      return true
    else
      render json: "Não é possível organizar uma gravata vazia", status: :bad_request
      return false
    end
  end
end
