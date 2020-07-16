require 'rails_helper'

describe MerchantRevenue do
  describe 'instance methods' do
    it '#most_revenue' do
      create_list(:invoice_item, 10)

      list = MerchantRevenue.new.most_revenue(5).to_a

      list_comparison = list.first[-1] > list.last[-1]
      expect(list_comparison).to eq(true)
    end

    it '#total_revenue' do
      merchant = create(:merchant)

      10.times do
        create(:invoice, merchant: merchant)
      end

      expectated = InvoiceItem.sum(:total)
      total = MerchantRevenue.new.total_revenue(merchant)

      expect(expectated).to eq(total)
    end

    it '#total_revenue_by_date' do
      merchant = create(:merchant)
      10.times do
        create(:invoice, merchant: merchant)
      end

      merchant2 = create(:merchant)
      5.times do
        create(:invoice, merchant: merchant2)
      end

      start = '2020-07-13 00:00:00'
      stop = '2020-09-26 23:59:59'

      expected = InvoiceItem.sum(:total)
      revenue_by_date = MerchantRevenue.new.total_revenue_by_date(start, stop)

      expect(expected).to eq(revenue_by_date)
    end
  end
end
