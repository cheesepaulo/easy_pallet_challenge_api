class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_one :ordernated_order_product, dependent: :destroy
end
