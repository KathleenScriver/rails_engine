FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..100) }
    unit_price { rand(1..10000000) }
    invoice
    item
  end
end
