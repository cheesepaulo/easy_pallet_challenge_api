require 'rails_helper'

RSpec.describe "Api::V1::OrganizeOrderService" do
  (1..5).each do |attemp|
    context "with valid data attemp #{attemp}" do

      let(:order) { create(:order) }

      before do
        create_list(:order_product, rand(2..5), order: order)

        @status = Api::V1::OrganizeOrderService.new(order).call()
        @full_layers_count = 0

        order.order_products.each do |op|
          division_result = op.quantity.divmod(op.product.ballast)
          @full_layers_count += division_result[0]
        end
      end

      it 'return true' do
        expect(@status).to eq(true)
      end

      it 'create a list of ordenated_order_products' do
        expect(Order.find(order.id).ordenated_order_products.present?).to eq(true)
      end

      it 'first layers are full' do
        Order.find(order.id).ordenated_order_products.each do |op|
          break if op.layer >= @full_layers_count
          expect(OrdenatedOrderProduct.find(op.id).quantity).to eq(
            OrdenatedOrderProduct.find(op.id).product.ballast)
        end
      end

      it 'last layers are picking' do
        Order.find(order.id).ordenated_order_products.reverse.each do |op|
          break if op.layer <= @full_layers_count
          expect(OrdenatedOrderProduct.find(op.id).quantity).not_to be == (
            OrdenatedOrderProduct.find(op.id).product.ballast)
        end
      end
    end
  end
end
