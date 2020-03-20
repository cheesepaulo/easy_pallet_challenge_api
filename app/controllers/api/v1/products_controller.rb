class Api::V1::ProductsController < Api::V1::BaseController
  before_action :set_product, except: [:index, :create]

  def index
    products = Product.all
    render json: products
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @product
  end

  def destroy
    @product.destroy
    render status: :ok
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:label, :ballast)
  end
end