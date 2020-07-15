require 'rails_helper'

describe "Items Search" do
  it 'can find a list of items that contain a fragment, case insensitive' do
    merchant = create(:merchant)

    item1_params = {
                    "name": "Toy Soldier",
                    "description": "A lil green dude",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "499"
                  }

    item2_params = {
                    "name": "Toyota Truck",
                    "description": "Retro truck",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "599"
                    }

    item3_params = {
                    "name": "Squirt Gun",
                    "description": "Water gun for fun in the sun!",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "899"
                    }
    Item.create!(item1_params)
    Item.create!(item2_params)
    Item.create!(item3_params)

    get '/api/v1/items/find_all?name=toy'

    json = JSON.parse(response.body, symbolize_names: true)

    names = json[:data].map do |item|
      item[:attributes][:name].downcase
    end

    expect(names.count).to eq(2)
    names.each do |name|
      expect(name).to include('toy')
    end
  end

  it 'can find an items that contain a fragment, case insensitive' do
    merchant = create(:merchant)
    5.times do
      create(:item, merchant: merchant)
    end
    item_params = {
                    "name": "Polly Pocket",
                    "description": "Nostalgic toy",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "499"
                  }

    Item.create!(item_params)

    get '/api/v1/items/find?name=pocket'
    json = JSON.parse(response.body, symbolize_names: true)
    name = json[:data][:attributes][:name].downcase

    expect(json[:data]).to be_a(Hash)
    expect(name).to include('pocket')
  end
end
