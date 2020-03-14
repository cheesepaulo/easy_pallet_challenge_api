FactoryBot.define do
  factory :product do
    label { FFaker::Lorem.word }
    ballast { rand(1...30) }
  end
end
