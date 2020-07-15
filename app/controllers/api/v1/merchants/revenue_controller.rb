class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    limit = params["quantity"]
    merchants = MerchantRevenue.new.most_revenue(limit)
    render json: MerchantSerializer.new(Merchant.find([merchants.keys]))
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    revenue = MerchantRevenue.new.total_revenue(merchant)
    render json: MerchantRevenueSerializer.new(revenue).info
  end
end
