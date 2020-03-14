require 'rails_helper'

RSpec.describe "Api::V1::Loads", type: :request do
  describe "GET /api/v1/loads" do

    before do
      @loads = create_list(:load, 10)
      get '/api/v1/loads'
    end

    it { expect(response).to have_http_status(:success) }

    it 'returns a list of elemments' do
      expect(json.count).to eql(10)
    end

    it 'returns a serialized list' do
      expect(json).to eql(each_serialized(Api::V1::LoadSerializer, @loads))
    end
  end
end
