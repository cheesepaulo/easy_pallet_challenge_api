FactoryBot.define do
  factory :order do
    code { FFaker::Lorem.word }
    bay { FFaker::Lorem.word }

    load
  end
end
