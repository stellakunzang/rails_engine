require 'rails_helper'

describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
  end

  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "class methods" do
    it ".price_to_dollars" do
      invoice_item = create(:invoice_item)
      expect(invoice_item.unit_price).to eq(123.45)
    end
  end
end