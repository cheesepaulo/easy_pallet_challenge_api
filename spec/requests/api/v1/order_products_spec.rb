require 'rails_helper'

RSpec.describe "Api::V1::OrderProducts", type: :request do
  
  describe "POST /api/v1/orders/:id/order_products" do
    context "with valid params" do
      let(:order){ create(:order) }
      let(:product){ create(:product) }
      let(:order_product_params) { attributes_for(:order_product, product_id: product.id) }

      before do 
        post "/api/v1/orders/#{order.id}/order_products", params: { order_product: order_product_params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'creates the record in database' do
        expect(OrderProduct.count).to eq(1)
      end

      it 'creates the right record' do
        expect(OrderProduct.last.product_id).to eq(order_product_params[:product_id])
        expect(OrderProduct.last.quantity).to eq(order_product_params[:quantity])
      end
    end

    context "with invalid params" do
      let(:order){ create(:order) }
      let(:product){ create(:product) }
      let(:order_product_params) { attributes_for(:order_product, product_id: nil) }

      before do 
        post "/api/v1/orders/#{order.id}/order_products", params: { order_product: order_product_params }
      end

      it "not creates the record" do
        expect(OrderProduct.count).to eq(0)
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "returns a json with errors messages" do
        expect(json).to include("errors")
      end
    end
  end
end