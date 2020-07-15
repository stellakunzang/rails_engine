require 'rails_helper'

describe MerchantRevenue do
  describe 'instance methods' do
    it '#most_revenue' do
      create_list(:invoice_item, 10)

      list = (MerchantRevenue.new.most_revenue(5)).to_a

      list_comparison = list.first[-1] > list.last[-1]
      expect(list_comparison).to eq(true)
    end
  end
end
