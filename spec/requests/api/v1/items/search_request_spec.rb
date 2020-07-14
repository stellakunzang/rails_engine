require 'rails_helper'

describe "Items Search" do
  it "can find items based on single query" do
    merchant = create(:merchant)
    5.times do
      create(:item, merchant: merchant)
    end
    item1_params = {
                    "name": "Polly Pocket",
                    "description": "Nostalgic toy",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "499"
                  }

    item2_params = {
                    "name": "Tomagatchi",
                    "description": "Retro toy",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "599"
                    }

    item1 = Item.create(item1_params)
    item2 = Item.create(item2_params)

    get '/api/v1/items/find?description=toy'

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"].count).to eq(2)
  end

  it "can find items based on mutliple queries" do
    merchant = create(:merchant)
    5.times do
      create(:item, merchant: merchant)
    end

    item1_params = {
                    "name": "Polly Pocket",
                    "description": "Nostalgic toy",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "499"
                  }

    item2_params = {
                    "name": "Tomagatchi",
                    "description": "Retro toy",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "599"
                    }

    item3_params = {
                    "name": "Squirt Gun",
                    "description": "Water gun for fun in the sun!",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "899"
                    }
    item1 = Item.create(item1_params)
    item2 = Item.create(item2_params)
    item3 = Item.create(item3_params)

    get '/api/v1/items/find?description=toy&name=squirt'

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"].count).to eq(3)
  end
end
