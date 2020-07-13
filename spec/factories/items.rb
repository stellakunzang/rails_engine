FactoryBot.define do
  factory :item do
    association :merchant
    name { Faker::Games::Zelda.item }
    description { Faker::Movies::Ghostbusters.quote }
    unit_price { rand(199..9999) }
  end
end
