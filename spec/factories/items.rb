FactoryBot.define do
  factory :item do
    association :merchant
    name { "Puppy Stuffy" }
    description { "Cute stuff." }
    unit_price { 12345 }
  end
end
