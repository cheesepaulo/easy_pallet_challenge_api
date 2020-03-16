FactoryBot.define do
  factory :order_product do
    order
    product
    quantity { rand(65...100) }
  end
end
