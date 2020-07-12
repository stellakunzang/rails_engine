class MerchantRevenue

  def most_revenue(limit)
    Invoice.joins(:merchant, :transactions, :invoice_items)
           .where('transactions.result =?', "success")
           .group('merchants.id')
           .order('sum(invoice_items.total) desc')
           .limit(limit)
           .sum('invoice_items.total')
  end
end
