FactoryBot.define do
  factory :order do
    code { FFaker::Lorem.word }
    bay { FFaker::Lorem.word }

    load
    after :create do |order|
      create_list :order_product, rand(1...10), order: order
    end
  end
end
