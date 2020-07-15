class Api::V1::Merchants::SearchController < ApplicationController

  def index
    search = MerchantSearch.new(query_params)
    results = search.results
    render json: MerchantSerializer.new(Merchant.find(results))
  end

  def show
    search = MerchantSearch.new(query_params)
    result = search.results.first
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
