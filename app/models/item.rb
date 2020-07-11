class Item < ApplicationRecord
  before_save :price_to_dollars
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def price_to_dollars
    self.unit_price = self.unit_price / 100.00
  end
end
