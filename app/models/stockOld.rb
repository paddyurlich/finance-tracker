class Stock < ActiveRecord::Base
  
  has_many :user_stocks
  has_many :users, through: :user_stocks
  
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end
  #example 
#   2.3.0 :007 > Stock.find_by_ticker('GOOG')
#   Stock Load (0.3ms)  SELECT  "stocks".* FROM "stocks" WHERE "stocks"."ticker" = ?  ORDER BY "stocks"."id" ASC LIMIT 1  [["ticker", "GOOG"]]
# +----+--------+---------------+------------+-------------------------+-------------------------+
# | id | ticker | name          | last_price | created_at              | updated_at              |
# +----+--------+---------------+------------+-------------------------+-------------------------+
# | 13 | GOOG   | Alphabet Inc. | 689.04     | 2016-05-05 08:58:30 UTC | 2016-05-05 08:58:30 UTC |
# +----+--------+---------------+------------+-------------------------+-------------------------+
# 1 row in set
  
  
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name
    
    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end
  # example is console: Stock.new_from_lookup("GOOG")
  # => #<Stock id: nil, ticker: "GOOG", name: "Alphabet Inc.", last_price: #<BigDecimal:3493060,'0.69838E3',18(18)>, created_at: nil, updated_at: nil> 
  
  
  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price
    
    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price
    'Unavailable' #retrun unavailable to neither closing price or opending price is available
  end
end


