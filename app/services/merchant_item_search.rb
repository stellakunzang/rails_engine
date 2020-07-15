class MerchantItemSearch
  def most_items(limit)
    Merchant.joins(:items)
            .group('merchants.id')
            .order('count(items) desc')
            .limit(limit)
            .count(:items)
  end
end
