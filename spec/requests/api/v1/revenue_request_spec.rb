require 'rails_helper'

describe 'Revenue' do
  it 'can calculate total revenue from all merchants across given dates' do
    merchant = create(:merchant)
    10.times do
      create(:invoice, merchant: merchant)
    end

    merchant2 = create(:merchant)
    5.times do
      create(:invoice, merchant: merchant2)
    end

    total = InvoiceItem.sum(:total)

    get '/api/v1/revenue?start=2020-07-12&end=2020-09-26'

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response['data']['attributes']['revenue']).to eq(total)
  end
end
