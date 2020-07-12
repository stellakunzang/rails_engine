FactoryBot.define do
  factory :customer do
    first_name { Faker::Artist.name }
    last_name { Faker::Beer.brand }
  end
end
