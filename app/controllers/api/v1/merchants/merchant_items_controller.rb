class Api::V1::Merchants::MerchantItemsController < ApplicationController
  def index
    limit = params["quantity"]
    merchants = MerchantItems.new.most_items(limit)
    render json: MerchantSerializer.new(Merchant.find([merchants.keys]))
  end
end
