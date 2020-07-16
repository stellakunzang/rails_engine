require 'rails_helper'

describe 'Merchants Search' do
  it 'can find a list of merchants that contain a fragment, case insensitive' do
    Merchant.create!({ "name": 'Krill King' })
    Merchant.create!({ "name":  'No Frill Grill' })
    Merchant.create!({ "name":  'Dill Pickle World' })
    Merchant.create!({ "name":  'Old Onion Factory' })

    get '/api/v1/merchants/find_all?name=ILL'

    json = JSON.parse(response.body, symbolize_names: true)

    names = json[:data].map do |merchant|
      merchant[:attributes][:name]
    end

    expect(names.sort).to eq(['Dill Pickle World', 'Krill King', 'No Frill Grill'])
  end

  it 'can find a merchants that contain a fragment, case insensitive' do
    Merchant.create!({ "name": 'Krill King' })

    get '/api/v1/merchants/find?name=ILL'

    json = JSON.parse(response.body, symbolize_names: true)

    name = json[:data][:attributes][:name].downcase

    expect(json[:data]).to be_a(Hash)
    expect(name).to include('ill')
  end
end
