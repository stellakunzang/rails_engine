FactoryBot.define do
  factory :invoice_item do
    association :item
    association :invoice
    quantity { rand(10) }
    unit_price { rand(199..9999) }
  end
end
