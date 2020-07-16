class Api::V1::Items::MerchantsController < ApplicationController
  def show
    item = Item.find(params[:item_id])
    id = item.merchant_id
    render json: MerchantSerializer.new(Merchant.find_by(id: id))
  end
end
