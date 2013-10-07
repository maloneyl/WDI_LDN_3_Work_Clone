require 'yahoofinance'

class Stock < Portfolio

  attr_accessor :stock_symbol, :share
  # :share means the quantity of the stock owned, e.g. 10 x AAPL stock
  # :stock_symbol means AAPL for Apple, GOOG for Google, etc.

  def self.get_quote(stock_symbol)
    return YahooFinance::get_standard_quotes(stock_symbol)[stock_symbol].lastTrade
  end

  # all below fucntions will need to take arguments...

  def name
  end

  def buy
  end

  def sell
  end

  def position # what it means for example is 10 AAPl stocks = $XXX
  end

end
