class InvoiceItem < ApplicationRecord
  include ActionView::Helpers::NumberHelper

  before_save :price_to_dollars
  before_save :calculate_total
  belongs_to :item
  belongs_to :invoice
  validates :item_id, presence: true
  validates :invoice_id, presence: true
  validates :quantity, presence: true
  validates :unit_price, presence: true

  def price_to_dollars
    if self.unit_price == self.unit_price.to_i
      unit_price = self.unit_price.to_i
    else
      unit_price = self.unit_price
    end

    if unit_price.class != Float
      self.unit_price = Money.new(unit_price, "USD")
    else
      self.unit_price = unit_price
    end
  end

  def calculate_total
    self.total = self.quantity * self.unit_price
  end
end
