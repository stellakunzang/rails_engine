class MerchantRevenue
  def total_revenue(merchant)
    Invoice.joins(:transactions, :invoice_items)
           .where('transactions.result =? AND merchant_id =?', 'success', merchant.id)
           .sum('invoice_items.total')
  end

  def most_revenue(limit)
    Invoice.joins(:transactions, :invoice_items)
           .where('transactions.result =?', 'success')
           .group('merchant_id')
           .order('sum(invoice_items.total) desc')
           .limit(limit)
           .sum('invoice_items.total')
  end

  def total_revenue_by_date(start, stop)
    Invoice.joins(:transactions, :invoice_items)
           .where('transactions.result =? AND invoices.created_at BETWEEN ? AND ?', 'success', start, stop)
           .sum('invoice_items.total')
  end
end
