class Api::V1::OrganizeOrderService
  def initialize(order)
    @order = order
    @order_products = order.order_products
    @layer = 0
    @pickings = []
    @picking_count = 0;
  end

  def call
    sort_by_quantity
    organize_and_create_full_layers_first

    if @picking_count > 0
      @layer += 1
      create_pickings
    else
      return true
    end
  end

  private

  def sort_by_quantity
    @order_products = @order_products.order(quantity: :desc)
  end

  def organize_and_create_full_layers_first
    begin
      @order_products.each do |op|
        division_result = op.quantity.divmod(op.product.ballast)

        @picking_count += division_result[1]
        @pickings.push(division_result)
        @pickings.last.push(op.product_id)

        count=1; while count <= division_result[0]
          @layer += 1; count +=1;
          @order.ordenated_order_products.build(product: op.product, layer: @layer, quantity: op.product.ballast)
        end
      end
      Order.transaction do
        @order.save!
      end
    rescue
      return false
    end
  end

  def create_pickings
    begin
      @pickings.each do |p|
        if p[1] > 0
          @order.ordenated_order_products.build(product_id: p[2], layer: @layer, quantity: p[1])
        end
      end
      Order.transaction do
        @order.save!
      end
    rescue
      return false
    end

    return true
  end
end
