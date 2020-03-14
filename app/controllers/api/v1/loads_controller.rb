class Api::V1::LoadsController < Api::V1::BaseController
  before_action :set_load, except: [:index]

  def index
    loads = Load.all
    render json: loads
  end

  def show
    render json: @load
  end

  private

  def set_load
    @load = Load.find(params[:id])
  end
end
