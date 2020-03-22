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

  describe "POST /api/v1/loads/:load_id/orders" do
    context "with valid params" do
      let(:order_params) { attributes_for(:order) }
      let(:load) { create(:load) }

      before do 
        post "/api/v1/loads/#{load.id}/orders", params: { order: order_params }
      end

      it { expect(response).to have_http_status(:created) }

      it 'the record has association with load' do
        expect(Load.find(load.id).orders.count).to eq(1)
      end

      it 'creates the record in database' do
        expect(Order.count).to eq(1)
      end

      it 'creates the right record' do
        expect(Order.last.code).to eq(order_params[:code])
        expect(Order.last.bay).to eq(order_params[:bay])
      end
    end

    context "with invalid params" do
      let(:order_params) { {foo: :bar} }
      let(:load) { create(:load) }

      before do 
        post "/api/v1/loads/#{load.id}/orders", params: { order: order_params }
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "responds with a error message" do
        expect(json).to have_key("errors")
      end

      it 'not creates the record in database' do
        expect(Order.count).to eq(0)
      end
    end
  end

  describe "PUT /api/v1/loads/:load_id/orders/:id" do
    context "with valid params" do
      let(:order){ create(:order)}
      let(:order_params) { attributes_for(:order) }
  
      before do
        put "/api/v1/orders/#{order.id}", params: { order: order_params }
      end
  
      it "updates the right record" do
        expect(Order.find(order.id).code).to eq(order_params[:code])
        expect(Order.find(order.id).bay).to eq(order_params[:bay])
      end
    end

    context "with invalid params" do
      let(:order){ create(:order)}
      let(:order_params){ attributes_for(:order, code: '', bay: '')}
  
      before do
        put "/api/v1/orders/#{order.id}", params: { order: order_params }
      end
  
      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "responds with a error message" do
        expect(json).to have_key("errors")
      end
    end
  end

  describe "DELETE /api/v1/orders/:id" do
    let(:order) { create(:order) }

    context "when order has no record associated" do
      before do
        create_list(:order, 2)
        delete "/api/v1/orders/#{order.id}"
      end
  
      it { expect(response).to have_http_status(:ok) }
  
      it 'removes the resource' do
        expect(Order.count).to eq(2)
      end
  
      it 'removes the right resource' do
        expect(Order.find_by(id: order.id)).to be(nil)
      end
    end 
    
    context "when product has records associated" do
      let(:order) { create(:order) }
      
      before do
        create(:order_product, order: order)
        create(:ordenated_order_product, order: order)

        delete "/api/v1/orders/#{order.id}"
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }

      it "responds with a error message" do
        expect(response.body).to eq("Não é possivel excluir uma gravata com items associados.")
      end
  
      it 'not removes the resource' do
        expect(Order.find_by(id: order.id)).to eq(order)
      end
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

      it 'respond with a success message' do
        expect(response.body).to eq("Gravata organizada com sucesso")
      end
    end

    context 'when order are empty' do
      before do
        create_list(:order_product, 5)
        post "/api/v1/order/#{order.id}/organize"
      end

      it { expect(response).to have_http_status(:bad_request) }

      it 'respond with an error message' do
        expect(response.body).to eq("Não é possível organizar uma gravata vazia")
      end

      it 'not create a list of ordenated_order_products' do
        expect(Order.find(order.id).ordenated_order_products.present?).to be false
      end
    end

    context 'when the order has already been organized' do
      before do
        create_list(:order_product, 5, order: order)
        2.times { post "/api/v1/order/#{order.id}/organize" }
      end

      it "respond with status code bad_request" do
        expect(response).to have_http_status(:bad_request)
      end

      it 'responde with an error message' do
        expect(response.body).to eq("Não é possivel organizar uma gravata já organizada")
      end

      it 'not update the ordenated_order_products' do
        expect(Order.find(order.id).ordenated_order_products.last.updated_at).to eql(
          order.ordenated_order_products.last.updated_at)
      end
    end
  end

  describe 'GET /api/v1/orders/:id/ordenated' do
    let(:order) { create(:order) }

    context 'with valid data' do
      before do
        create_list(:order_product, 5, order: order)
        Api::V1::OrganizeOrderService.new(order).call()
        get "/api/v1/orders/#{order.id}/ordenated"
      end

      it "returns a status code ok" do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a serialized list of ordenated_order_products' do
        expect(json).to eql(each_serialized(Api::V1::OrdenatedOrderProductSerializer,
          order.ordenated_order_products))
      end
    end
  end
end
