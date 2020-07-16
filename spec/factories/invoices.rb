FactoryBot.define do
  factory :invoice do
    association :customer
    association :merchant
    status { 'shipped' }

    after :create do |invoice|
      create :transaction, invoice: invoice
    end

    after :create do |invoice|
      create :invoice_item, invoice: invoice
    end
  end
end
