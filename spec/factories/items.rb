FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Friends.quote }
    unit_price { rand(1..1000) }
    merchant
  end
end
