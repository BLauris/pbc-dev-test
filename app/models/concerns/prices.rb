module Prices
  extend ActiveSupport::Concern
  
  def euro_price
    BigDecimal.new(price_in_cents / 100)
  end
  
  def dolar_price
    # TODO: return euros for now
    euro_price
  end
  
end