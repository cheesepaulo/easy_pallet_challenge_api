require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  describe "GET /api/v1/orders/:id" do

    let(:order) { create(:order) }

    context 'when resource exists' do
      before do
        get "/api/v1/orders/#{order.id}"
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns the correct order' do
        expect(json["id"]).to eql(order.id)
      end

      it 'returns a serialized order' do
        expect(json).to eql(serialized(Api::V1::OrderSerializer, order))
      end

      it 'returns a order with an list of order_products' do
        expect(json["order_products"]).to eql(each_serialized(Api::V1::OrderProductSerializer, order.order_products))
      end
    end

    context 'when resource not exists' do
      before do
        get "/api/v1/orders/invalid_id"
      end

      it { expect(response).to have_http_status(:not_found) }
    end
  end

  describe "POST /api/v1/order/:id/organize" do

    let(:order) { create(:order) }

    context 'when order has a list of order_products' do
      before do
        create_list(:order_product, 5, order: order)
        post "/api/v1/order/#{order.id}/organize"
      end

      it { expect(response).to have_http_status(:created) }
    end

    context 'when order are empty' do
      before do
        create_list(:order_product, 5)
        post "/api/v1/order/#{order.id}/organize"
      end

      it { expect(response).to have_http_status(:no_content) }

      it 'not create a list of ordenated_order_products' do
        expect(Order.find(order.id).ordenated_order_products.present?).to be false
      end
    end
  end
end
