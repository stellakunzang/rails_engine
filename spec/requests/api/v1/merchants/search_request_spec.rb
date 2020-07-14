require 'rails_helper'

describe "Merchants Search" do
  it "can find merchants based on single query" do
    merchant = Merchant.create!({name: "Toys R Us"})

    get '/api/v1/merchants/find?name=toy'

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"].count).to eq(1)
  end

  it "can find items based on mutliple queries" do
    merchant1 = Merchant.create!({name: "Toys R Us"})
    merchant2 = Merchant.create!({name: "Dumptrucks R Us"})

    get '/api/v1/merchants/find?name=us'

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"].count).to eq(2)
  end
end
