require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(3)
    json[:data].each do |item|
      expect(item[:type]).to eq("item")
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes]).to have_key(:merchant_id)
    end
  end

  it "can get one item by its id" do
    id = create(:item).id
    item = Item.last

    get "/api/v1/items/#{id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:id]).to eq("#{id}")

    expect(json[:data][:attributes][:name]).to eq(item.name)
    expect(json[:data][:attributes][:description]).to eq(item.description)
    expect(json[:data][:attributes][:unit_price]).to eq(item.unit_price)
    expect(json[:data][:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = {
                    "name": "Polly Pocket",
                    "description": "Nostalgic toy",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "499"
                  }

    post "/api/v1/items", params: item_params

    item = Item.last

    json = JSON.parse(response.body, symbolize_names: true)

    new_item = json[:data]
    expect(new_item[:attributes][:name]).to eq(item.name)
    expect(new_item[:attributes][:description]).to eq(item.description)
    expect(new_item[:attributes][:unit_price]).to eq(item.unit_price)
    expect(new_item[:attributes][:merchant_id]).to eq(item.merchant_id)
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { "name": "Tomagatchi" }

    put "/api/v1/items/#{id}", params: item_params

    json = JSON.parse(response.body, symbolize_names: true)

    item = Item.find_by(id: id)

    updated_item = json[:data]
    expect(updated_item[:attributes][:name]).to eq(item.name)
    expect(updated_item[:attributes][:description]).to eq(item.description)
    expect(updated_item[:attributes][:unit_price]).to eq(item.unit_price)
    expect(updated_item[:attributes][:merchant_id]).to eq(item.merchant_id)
    expect(updated_item[:attributes][:name]).to_not eq(previous_name)
  end

  it "can destroy an item" do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    json = JSON.parse(response.body, symbolize_names: true)

    deleted_item = json[:data]
    expect(deleted_item[:attributes][:name]).to eq(item.name)
    expect(deleted_item[:attributes][:description]).to eq(item.description)
    expect(deleted_item[:attributes][:unit_price]).to eq(item.unit_price)
    expect(deleted_item[:attributes][:merchant_id]).to eq(item.merchant_id)

    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
