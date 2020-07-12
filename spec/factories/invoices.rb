FactoryBot.define do
  factory :invoice do
    association :customer
    association :merchant
    status { "shipped" }

    after :create do |invoice|
      create :transaction, invoice: invoice
    end 
  end
end
