class ItemSearch
  def initialize(query)
    @query = query
  end

  def results
    query_results = []
    @query.each do |attribute, search_term|
      query_results << Item.where("lower(#{attribute}) LIKE ?", "%#{search_term.downcase}%").pluck(:id)
    end
    query_results.flatten.uniq
  end
end
