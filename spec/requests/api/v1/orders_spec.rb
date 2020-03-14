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
  end
end
