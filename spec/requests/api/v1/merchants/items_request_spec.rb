require 'rails_helper'

describe "Item Merchant" do
  it "can return the items for a merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(merchant["data"]["type"]).to eq("merchant")
  end
end
