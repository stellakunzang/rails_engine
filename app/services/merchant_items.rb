class MerchantItems
  def most_items(limit)
    Invoice.joins(:invoice_items, :transactions)
           .where('transactions.result =?', "success")
           .group(:merchant_id)
           .order('sum(invoice_items.quantity) desc')
           .limit(limit)
           .sum('invoice_items.quantity')
  end
end
