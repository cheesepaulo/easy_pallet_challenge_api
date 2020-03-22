class Api::V1::LoadSerializer < ActiveModel::Serializer
  attributes :id, :code, :delivery_date

  def delivery_date
    self.object.delivery_date.strftime("%d/%m/%Y %H:%M")
  end
end
