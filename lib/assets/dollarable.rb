module Dollarable

  def price_to_dollars
    unit_price = strip_trailing_zero(self.unit_price)
    if unit_price.class != Float
      self.unit_price = Money.new(unit_price, "USD")
    else
      self.unit_price = unit_price
    end
  end

  def strip_trailing_zero(price)
    if self.unit_price == self.unit_price.to_i
      self.unit_price.to_i
    else
      self.unit_price
    end
  end

end
