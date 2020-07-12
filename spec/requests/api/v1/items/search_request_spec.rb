require 'rails_helper'

describe "Items Search" do
  xit "can return a single item" do
    merchant = create(:merchant)
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

    get '/api/v1/item/find?description=toy'

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    binding.pry

    expect(items["data"].count).to eq(2)
  end
end
