module Dollarable
  def price_to_dollars
    unit_price = strip_trailing_zero(self.unit_price)
    self.unit_price = if unit_price.class != Float
                        Money.new(unit_price, 'USD')
                      else
                        unit_price
                      end
  end

  def strip_trailing_zero(_price)
    if unit_price == unit_price.to_i
      unit_price.to_i
    else
      unit_price
    end
  end
end
