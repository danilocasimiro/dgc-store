FactoryBot.define do
  factory :product do
    name { Faker::Name.name }
    price { Faker::Commerce.price }
    stock { Faker::Number.number }
    association :product_type
  end
end
