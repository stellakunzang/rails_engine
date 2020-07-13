class Api::V1::Items::SearchController < ApplicationController

  def show
    query_keys = params.keys[0..-3]
    query_values = []
    query_keys.each { |key| query_values << params[key] }
    query_keys.zip(query_values)

  end

end
