class MerchantRevenue

  def total_revenue(merchant)
    Invoice.joins(:transactions, :invoice_items)
           .where('transactions.result =? AND merchant_id =?', "success", merchant.id)
           .sum('invoice_items.total')
  end

  def most_revenue(limit)
    Invoice.joins(:merchant, :transactions, :invoice_items)
           .where('transactions.result =?', "success")
           .group('merchants.id')
           .order('sum(invoice_items.total) desc')
           .limit(limit)
           .sum('invoice_items.total')
  end
end
