require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants).to be_instance_of(Hash)
    expect(merchants.keys.first).to eq("data")
    expect(merchants["data"]).to be_instance_of(Array)
    expect(merchants["data"].count).to eq(3)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant).to be_instance_of(Hash)
    expect(merchant.keys.first).to eq("data")
    expect(merchant["data"]["id"]).to eq("#{id}")
  end
end
