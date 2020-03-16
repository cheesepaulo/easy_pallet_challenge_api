require 'rails_helper'

RSpec.describe "Api::V1::OrganizeOrderService" do
  context "with valid data" do

    let(:order) { create(:order) }

    before do
      create_list(:order_product, 3, order: order)
      @status = Api::V1::OrganizeOrderService.new(order).call()

      @full_layers_count = 0
      # @pickings = []
      # @pickings_layers_count = 0
      # @layer = 0
      # count = 0

      order.order_products.each do |op|
        division_result = op.quantity.divmod(op.product.ballast)
        @full_layers_count += division_result[0]
        # @pickings.push(division_result)
        # @pickings.last.push(op.product_id)
        # count=1; while count <= division_result[0]
        #   @layer += 1; count +=1;
        # end
      end
    end

    it 'return true' do
      expect(@status).to eq(true)
    end

    it 'create a list of ordenated_order_products' do
      expect(order.ordenated_order_products.present?).to eq(true)
    end

    it 'first layers are full' do
      order.ordenated_order_products.each do |op|
        expect(op.quantity).to eq(op.product.ballast)
        break if op.layer >= @full_layers_count
      end
    end

    it 'last layer are picking' do
      expect(order.ordenated_order_products.last.quantity)
        .not_to be == (order.ordenated_order_products.last.product.ballast)
    end
  end
end
