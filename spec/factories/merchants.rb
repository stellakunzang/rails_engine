FactoryBot.define do
  factory :merchant do
    name { Faker::Games::Zelda.location }
  end
end
