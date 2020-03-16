FactoryBot.define do
  factory :product do
    label { FFaker::Lorem.word }
    ballast { rand(20...30) }
  end
end
