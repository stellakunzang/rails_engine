require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data].length).to eq(3)

    json[:data].each do |merchant|
      expect(merchant[:type]).to eq("merchant")
      expect(merchant[:attributes]).to have_key(:name)
    end
  end

  it "can get one merchant by its id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    json = JSON.parse(response.body, symbolize_names: true)
    expect(json[:data][:attributes][:id]).to eq(merchant.id)
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it "can create a new merchant" do
    merchant_params = {
                    "name": "We Be Toys"
                  }

    post "/api/v1/merchants", params: merchant_params

    merchant = Merchant.last

    json = JSON.parse(response.body, symbolize_names: true)

    new_merchant = json[:data]
    expect(new_merchant[:attributes][:name]).to eq(merchant.name)
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { "name": "Toys R Us" }

    put "/api/v1/merchants/#{id}", params: merchant_params

    json = JSON.parse(response.body, symbolize_names: true)

    expect(json[:data][:attributes][:name]).to eq("Toys R Us")
    expect(json[:data][:attributes][:name]).to_not eq("#{previous_name}")
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect{ delete "/api/v1/merchants/#{merchant.id}" }.to change(Merchant, :count).by(-1)

    json = JSON.parse(response.body, symbolize_names: true)

    deleted_merchant = json[:data]
    expect(deleted_merchant[:attributes][:name]).to eq(merchant.name)
    expect(deleted_merchant[:attributes][:id]).to eq(merchant.id)

    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
