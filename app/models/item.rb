class Item < ApplicationRecord
  before_save :price_to_dollars
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, presence: true
  validates :description, presence: true
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

end
