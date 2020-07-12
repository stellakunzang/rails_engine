class AddTotalToInvoiceItem < ActiveRecord::Migration[5.2]
  def change
    add_column :invoice_items, :total, :float, default: 0
  end
end
