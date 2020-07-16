class InvoiceItem < ApplicationRecord
  before_save :calculate_total
  belongs_to :item
  belongs_to :invoice
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true

  def calculate_total
    self.total = quantity * unit_price
  end

end
