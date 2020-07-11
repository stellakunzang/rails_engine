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

  it ""

end
