class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    limit = params["quantity"]
    merchants = MerchantItemSearch.new.most_items(limit)
    render json: MerchantSerializer.new(Merchant.find([merchants.keys]))
  end
end
