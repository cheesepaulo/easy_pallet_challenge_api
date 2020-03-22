class Order < ApplicationRecord
  belongs_to :load
  has_many :order_products, dependent: :destroy
  has_many :ordenated_order_products, dependent: :destroy

  validates_presence_of :code, :bay
end
