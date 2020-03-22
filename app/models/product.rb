class Product < ApplicationRecord
  validates_presence_of :label, :ballast

  has_many :order_products
  has_many :ordenated_order_products
end
