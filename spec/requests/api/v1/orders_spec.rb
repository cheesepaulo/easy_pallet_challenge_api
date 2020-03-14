require 'rails_helper'

RSpec.describe "Api::V1::Orders", type: :request do
  describe "GET /api/v1/orders/:id" do

    let(:order) { create(:order) }

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

    it 'returns a list of order_products' do
      expect(json["order_products"]).to eql(each_serialized(Api::V1::OrderProductSerializer, order.order_products))
    end
  end
end
