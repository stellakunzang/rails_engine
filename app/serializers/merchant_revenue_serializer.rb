class MerchantRevenueSerializer
  def initialize(revenue)
    @revenue = revenue
  end

  def info
    {
      "data": {
          "id": nil,
          "attributes": {
            "revenue": @revenue
          }
      }
    }
  end
end
