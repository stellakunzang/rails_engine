class Api::V1::Items::SearchController < ApplicationController

  def index
    search = ItemSearch.new(query_params)
    results = search.results
    render json: ItemSerializer.new(Item.find(results))
  end

  def show
    search = ItemSearch.new(query_params)
    result = search.results.first
    render json: ItemSerializer.new(Item.find_by(id: result))
  end

  private

  def query_params
    query_keys = params.keys[0..-3]
    query_values = []
    query_keys.each { |key| query_values << params[key] }
    query_keys.zip(query_values)
  end

end
