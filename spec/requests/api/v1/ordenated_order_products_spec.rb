require 'rails_helper'

RSpec.describe "Api::V1::OrderProducts", type: :request do

  describe "GET /api/v1/orders/:id/ordenated_order_products" do

    context "when order exists" do
      let(:order){ create(:order) }

      before do
        @ordenated_order_products = create_list(:ordenated_order_product, 10, order: order)
        get "/api/v1/orders/#{order.id}/ordenated_order_products"
      end

      it { expect(response).to have_http_status(:success) }

      it 'returns a list of elemments' do
        expect(json.count).to eql(10)
      end

      it 'returns a serialized list' do
        expect(json).to eql(each_serialized(Api::V1::OrdenatedOrderProductSerializer, @ordenated_order_products))
      end
    end 

    context "when order not exists" do
      before do
        get "/api/v1/orders/invalid_id/ordenated_order_products"
      end

      it { expect(response).to have_http_status(:not_found) }
    end 
  end
end