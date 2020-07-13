require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items).to be_instance_of(Hash)
    expect(items.keys.first).to eq("data")
    expect(items["data"]).to be_instance_of(Array)
    expect(items["data"].count).to eq(3)
  end

  it "can get one item by its id" do
    id = create(:item).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(item).to be_instance_of(Hash)
    expect(item.keys.first).to eq("data")
    expect(item["data"]["id"]).to eq("#{id}")
  end

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = {
                    "name": "Polly Pocket",
                    "description": "Nostalgic toy",
                    "merchant_id": "#{merchant.id}",
                    "unit_price": "499"
                  }

    post "/api/v1/items", params: {item: item_params}

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"]["attributes"]["name"]).to eq("Polly Pocket")
    expect(response["data"]["attributes"]["description"]).to eq("Nostalgic toy")
  end

  it "can update an existing item" do
    id = create(:item).id
    previous_name = Item.last.name
    item_params = { "name": "Tomagatchi" }

    put "/api/v1/items/#{id}", params: {item: item_params}

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"]["attributes"]["name"]).to eq("Tomagatchi")
    expect(response["data"]["attributes"]["name"]).to_not eq("#{previous_name}")
  end

  it "can destroy an item" do
    item = create(:item)

    expect{ delete "/api/v1/items/#{item.id}" }.to change(Item, :count).by(-1)

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response).to be_instance_of(Hash)
    expect(response.keys.first).to eq("data")
    expect(response["data"]["id"]).to eq("#{item.id}")

    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
