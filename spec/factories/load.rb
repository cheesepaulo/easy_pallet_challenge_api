FactoryBot.define do
  factory :load do
    code { FFaker::Lorem.word }
    delivery_date { FFaker::Time.datetime }
  end
end
