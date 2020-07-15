class Api::V1::RevenueController < ApplicationController
  def show
    start = convert_date(params[:start])
    stop = convert_date(params[:end])
    total_revenue = MerchantRevenue.new.total_revenue_by_date(start, stop)
    render json: MerchantRevenueSerializer.new(total_revenue).info
  end

  private

  def convert_date(date_params)
    date = DateTime.parse(date_params)
    date.strftime("%a, %d %b %Y")
  end
end
