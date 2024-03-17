FactoryBot.define do
  factory :company do
    owner_id { Faker::Number.hexadecimal }
  end
end
