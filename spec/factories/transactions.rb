FactoryBot.define do
  factory :transaction do
    credit_card_number { '1234567812345678' }
    result { 'success' }
  end
end
