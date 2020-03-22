class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates_uniqueness_of :product
end
