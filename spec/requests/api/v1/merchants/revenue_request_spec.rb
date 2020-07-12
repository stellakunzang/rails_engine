require 'rails_helper'

describe "Merchant Revenue" do
  it "can return list of merchants sorted by revenue" do
    create_list(:invoice_item, 5)

    get '/api/v1/merchants/most_revenue?quantity=5'

    expect(response).to be_successful

    body = response.body
    response = JSON.parse(body)

    expect(response["data"].count).to eq(5)
  end
end
