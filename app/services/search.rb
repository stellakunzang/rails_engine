class Search

  def results(class_name, query)
    query_results = []
    query.each do |attribute, search_term|
      query_results << class_name.where("lower(#{attribute}) LIKE ?", "%#{search_term.downcase}%").pluck(:id)
    end
    query_results.flatten.uniq
  end

end
