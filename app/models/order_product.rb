class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates_presence_of :quantity
  validates_uniqueness_of :product, scope: :order_id
end
