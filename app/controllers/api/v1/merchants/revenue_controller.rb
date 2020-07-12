class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    limit = params["quantity"]
    merchants = MerchantRevenue.new.most_revenue(limit)
    render json: MerchantSerializer.new(Merchant.find([merchants.keys]))
  end

end
