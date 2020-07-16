class Api::V1::Merchants::SearchController < ApplicationController
  def index
    results = Search.new.results(Merchant, query_params)
    render json: MerchantSerializer.new(Merchant.find(results))
  end

  def show
    result = Search.new.results(Merchant, query_params).first
    render json: MerchantSerializer.new(Merchant.find_by(id: result))
  end

  private

  def query_params
    query_keys = params.keys[0..-3]
    query_values = []
    query_keys.each { |key| query_values << params[key] }
    query_keys.zip(query_values)
  end
end
