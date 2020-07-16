require './lib/assets/dollarable'

class Item < ApplicationRecord
  before_save :price_to_dollars
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  include Dollarable
end
