require 'rails_helper'

RSpec.describe "Api::V1::Products", type: :request do
  describe "GET /api/v1/products" do

    before do
      @products = create_list(:product, 10)
      get '/api/v1/products'
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns a list of elemments' do
      expect(json.count).to eql(10)
    end

    it 'returns a serialized list' do
      expect(json).to eql(each_serialized(Api::V1::ProductSerializer, @products))
    end
  end

  describe "POST /api/v1/products" do
    context "with valid params" do
      let(:product_params) { attributes_for(:product) }

      before do 
        post '/api/v1/products', params: { product: product_params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'creates the record in database' do
        expect(Product.count).to eq(1)
      end

      it 'creates the right record' do
        expect(Product.last.label).to eq(product_params[:label])
        expect(Product.last.ballast).to eq(product_params[:ballast])
      end
    end

    context "with invalid params" do
      let(:product_params) { {foo: :bar} }

      before do 
        post '/api/v1/products', params: { product: product_params }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "returns a json with error messages" do
        expect(json).to include("errors")
      end
    end
  end

  describe "DELETE /api/v1/products/:id" do
    let(:product) { create(:product) }

    context "when product has no record associated" do
      before do
        create_list(:product, 2)
        delete "/api/v1/products/#{product.id}"
      end
  
      it { expect(response).to have_http_status(:ok) }
  
      it 'removes the resource' do
        expect(Product.count).to eq(2)
      end
  
      it 'removes the right resource' do
        expect(Product.find_by(id: product.id)).to be(nil)
      end
    end 
    
    context "when product has records associated" do
      
      let(:product) { create(:product) }
      
      before do
        create(:order_product, product: product)
        create(:ordenated_order_product, product: product)

        delete "/api/v1/products/#{product.id}"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "responds with a error message" do
        expect(json).to have_key("errors")
      end
  
      it 'not removes the resource' do
        expect(Product.find_by(id: product.id)).to eq(product)
      end
    end
  end

  describe "PUT /api/v1/products/:id" do
    let(:product) { create(:product) }
    let(:product_params) { attributes_for(:product) }

    before do
      create_list(:product, 2)
      put "/api/v1/products/#{product.id}", params: { product: product_params }
    end

    it "updates the right record" do
      expect(Product.find(product.id).label).to eq(product_params[:label])
      expect(Product.find(product.id).ballast).to eq(product_params[:ballast])
    end
  end
end