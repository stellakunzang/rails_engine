require 'rails_helper'

describe "Item Merchant" do
  it "can return the items for a merchant" do
    merchant = create(:merchant)
    5.times do
      create(:item, merchant: merchant)
    end

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].first["type"]).to eq("item")
    expect(items["data"].length).to eq(5)
  end
end
