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

  it "can create a new merchant" do
    merchant_params = {
                    "name": "We Be Toys"
                  }

    post "/api/v1/merchants", params: {merchant: merchant_params}

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"]["attributes"]["name"]).to eq("We Be Toys")
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { "name": "Toys R Us" }

    put "/api/v1/merchants/#{id}", params: {merchant: merchant_params}

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"]["attributes"]["name"]).to eq("Toys R Us")
    expect(response["data"]["attributes"]["name"]).to_not eq("#{previous_name}")
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response).to be_instance_of(Hash)
    expect(response.keys.first).to eq("data")
    expect(response["data"]["id"]).to eq("#{merchant.id}")

    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
