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

  describe "POST /api/v1/loads" do
    context "with valid params" do
      let(:load_params) { attributes_for(:load) }

      before do 
        post '/api/v1/loads', params: { load: load_params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'creates the record in database' do
        expect(Load.count).to eq(1)
      end

      it 'creates the right record' do
        expect(Load.last.code).to eq(load_params[:code])
        expect(Load.last.delivery_date).to eq(load_params[:delivery_date])
      end
    end

    context "with invalid params" do
      let(:load_params) { {foo: :bar} }

      before do 
        post '/api/v1/loads', params: { load: load_params }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "returns a json with error messages" do
        expect(json).to include("errors")
      end
    end
  end

  describe "DELETE /api/v1/loads/:id" do
    let(:load) { create(:load) }

    before do
      create_list(:load, 2)
      delete "/api/v1/loads/#{load.id}"
    end

    it { expect(response).to have_http_status(:ok) }

    it 'removes the resource' do
      expect(Load.count).to eq(2)
    end

    it 'removes the right resource' do
      expect(Load.find_by(id: load.id)).to be(nil)
    end
  end

  describe "PUT /api/v1/loads/:id" do
    let(:load) { create(:load) }
    let(:load_params) { attributes_for(:load) }

    before do
      create_list(:load, 2)
      put "/api/v1/loads/#{load.id}", params: { load: load_params }
    end

    it "updates the right record" do
      expect(Load.find(load.id).code).to eq(load_params[:code])
    end
  end
end
