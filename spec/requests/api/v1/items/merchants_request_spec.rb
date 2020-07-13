require 'rails_helper'

describe "Item Merchant" do
  it "can return the merchant for an item" do
    item = create(:item)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["type"]).to eq("merchant")
  end
end
