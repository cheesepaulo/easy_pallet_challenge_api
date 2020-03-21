class Api::V1::LoadDetailSerializer < ActiveModel::Serializer
  attributes :id, :code, :delivery_date
  has_many :orders

  def delivery_date
    self.object.delivery_date.strftime("%d/%m/%Y %H:%M")
  end
end
