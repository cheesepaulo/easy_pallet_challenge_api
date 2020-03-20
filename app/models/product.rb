class Product < ApplicationRecord
  validates_presence_of :label, :ballast
end
