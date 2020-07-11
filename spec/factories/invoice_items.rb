FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice 
    quantity { 5 }
    unit_price { 12345 }
  end
end
