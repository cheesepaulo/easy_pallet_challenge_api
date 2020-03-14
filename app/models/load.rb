class Load < ApplicationRecord
  has_many :orders, dependent: :destroy
end
