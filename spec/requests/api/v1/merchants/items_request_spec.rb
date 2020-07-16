require 'rails_helper'

describe 'Item Merchant' do
  it 'can return the items for a merchant' do
    merchant = create(:merchant)
    5.times do
      create(:item, merchant: merchant)
    end

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].first['type']).to eq('item')
    expect(items['data'].length).to eq(5)
  end

  it "doesn't return items from other merchants" do
    merchant = create(:merchant)
    5.times do
      create(:item, merchant: merchant)
    end

    merchant2 = create(:merchant)
    5.times do
      create(:item, merchant: merchant2)
    end

    merchant3 = create(:merchant)
    5.times do
      create(:item, merchant: merchant3)
    end

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items['data'].length).to eq(5)
  end

  it 'can return merchants ranked by total number of items' do
    merchant1 = create(:merchant)
    5.times do
      create(:item, merchant: merchant1)
      create(:invoice, merchant: merchant1)
    end

    merchant2 = create(:merchant)
    10.times do
      create(:item, merchant: merchant2)
      create(:invoice, merchant: merchant2)
    end

    merchant3 = create(:merchant)
    3.times do
      create(:item, merchant: merchant3)
      create(:invoice, merchant: merchant3)
    end

    get '/api/v1/merchants/most_items?quantity=3'

    merchants = JSON.parse(response.body)

    expect(merchants['data'].first['type']).to eq('merchant')
    expect(merchants['data'].length).to eq(3)
  end
end
