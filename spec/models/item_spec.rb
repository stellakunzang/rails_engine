require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
  end

  describe "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "class methods" do
    it ".price_to_dollars" do
      item = create(:item)
      expect(item.unit_price.class).to eq(Float)
    end

    it ".price_to_dollars(sad path)" do
      merchant = create(:merchant)
      item = Item.create({
                          name: "doll",
                          description: "sad face",
                          merchant_id: merchant.id,
                          unit_price: 30.99
                          })
      expect(item.unit_price).to eq(30.99)
    end
  end
end
