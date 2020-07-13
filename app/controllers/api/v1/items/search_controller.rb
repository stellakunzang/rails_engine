class Api::V1::Items::SearchController < ApplicationController

  def show
    search = ItemSearch.new(query_params)
    results = search.results
    render json: ItemSerializer.new(Item.find(results))
  end

  private

  def query_params
    query_keys = params.keys[0..-3]
    query_values = []
    query_keys.each { |key| query_values << params[key] }
    query_keys.zip(query_values)
  end

end
