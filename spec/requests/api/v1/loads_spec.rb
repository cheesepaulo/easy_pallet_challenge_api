require 'rails_helper'

RSpec.describe "Api::V1::Loads", type: :request do
  describe "GET /api/v1/loads" do

    before do
      create_list(:load, 10)
      get '/api/v1/loads'
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns a list of elemments' do
      expect(json.count).to eql(10)
    end
  end
end
