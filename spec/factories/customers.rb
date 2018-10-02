FactoryBot.define do
  factory :customer do
    first_name { "Kat" }
    last_name { "Banana" }
    created_at { "2012-03-27 14:54:09 UTC" }
    updated_at { Time.now }
  end
end
