class Api::V1::OrdersController < Api::V1::BaseController
  before_action :set_load

  def show
    render json: @order
  end

  private

  def set_load
    @order = Order.find(params[:id])
  end
end
