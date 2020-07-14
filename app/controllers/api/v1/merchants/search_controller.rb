class Api::V1::Merchants::SearchController < ApplicationController

  def show
    search = MerchantSearch.new(query_params)
    results = search.results
    render json: MerchantSerializer.new(Merchant.find(results))
  end

  private

  def query_params
    query_keys = params.keys[0..-3]
    query_values = []
    query_keys.each { |key| query_values << params[key] }
    query_keys.zip(query_values)
  end

end
