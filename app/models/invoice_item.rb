class InvoiceItem < ApplicationRecord
  before_save :price_to_dollars
  belongs_to :item
  belongs_to :invoice
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true

  def price_to_dollars
    self.unit_price = self.unit_price / 100.00
  end
end
