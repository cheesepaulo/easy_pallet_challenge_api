class Load < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates_presence_of :code, :delivery_date
end
