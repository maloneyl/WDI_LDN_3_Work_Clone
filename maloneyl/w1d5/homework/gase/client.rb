class Client < Brokerage

  attr_accessor :name, :portfolios
  # portfolios is a hash

  def initialize(client, balance)
    @client = client
    @balance = balance
    @portfolios = {}
  end

  # the balance is a property of client, each time something happen with the portfolios that this instanc of client have , this balance property should be updated
  def balance
    @balance # changes in portfolio
  #  if ((share * price) < balance) && ((balance - (share * price)) < balance) # @client[name]
  #    balance -= (share * price )
  end

  def deposit(amount)
    @balance += amount
    puts "New account balance: $#{balance}"
  end

  def withdraw(amount)
    @balance -= amount
    puts "New account balance: $#{balance}"
  end

  # function verifying the balance for buying shares
  # you can't go below 0 in balance, can't buy more shares than client has $ for
  def balance_sufficient?
    @money_required <= @balance
  end

  # function to sell stock in portfolio
  def sell_stock(client_name, stock_symbol, stock_quantity, portfolio_name)
    @money_earned = Stock.get_quote(stock_symbol) * stock_quantity
    if stock_quantity <= #quantity_actually_in_portfolio
      deposit(money_required)
      # and delete from portfolio
    else puts "ERROR: Insufficient shares"
    end
  end

  # function to buy stock
  def buy_stock(client_name, stock_symbol, stock_quantity, portfolio_name)
    @money_required = Stock.get_quote(stock_symbol) * stock_quantity
    if balance_sufficient? == true
      withdraw(money_required)
      @brokerage.clients[client_name].portfolios[portfolio_name].update(stock_symbol: stock_quantity) # and add to portfolio
    else puts "ERROR: Insufficient funds"
    end
  end

end