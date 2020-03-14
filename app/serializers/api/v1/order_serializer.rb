class Api::V1::OrderSerializer < ActiveModel::Serializer
  attributes :id, :load_id, :code, :bay
end
