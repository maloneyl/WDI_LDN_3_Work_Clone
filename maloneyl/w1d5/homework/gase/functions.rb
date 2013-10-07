# this file contains all the functions that will be called from main.rb

# the 7 functions are:
# Create an account for client (name, balance),
# Every client can create multiple portfolios,
# A client can buy stocks at market rate; these stocks will be added to a portfolio and the purchase amount subtracted from cash. (You cannot go to a negative cash balance),
# A client can sell a stock. The proceeds go into his account,
# List all client portfolios and their values (each portfolio value and sum of portfolio values) and the account balance,
# List all stocks in a portfolio,
# List all clients.

# Create an account for client (name, balance)
def create_client
  puts "CREATE NEW CLIENT ACCOUNT"
  print "Name of client: "
  client_name = gets.chomp.split.map(&:capitalize).join(" ") # capitalize first letter of every word
  print "Starting balance: $"
  balance = gets.chomp.to_f
  @brokerage.add_client(client_name, balance)
end

# Every client can create multiple portfolios, e.g. Tech, Fashion, etc.
def create_portfolio
  puts "CREATE NEW PORTFOLIO"
  print "Name of client (existing): "
  client_name = gets.chomp.split.map(&:capitalize).join(" ")
  puts @brokerage.client(client_name) # test
  print "Name of portfolio to add: "
  portfolio_name = gets.chomp.split.map(&:capitalize).join(" ")
  @brokerage.clients[client_name].portfolios = portfolio_name
  puts @brokerage.clients[client_name].portfolios # test
end

def buy_stock_for_client
  puts "HELP CLIENT BUY STOCK"
  print "Name of client (existing): "
  client_name = gets.chomp.split.map(&:capitalize).join(" ")
#  puts @brokerage.client(client_name) # test
  print "Name of portfolio (existing): "
  portfolio_name = gets.chomp.split.map(&:capitalize).join(" ")
  print "Enter the stock symbol: "
  stock_symbol = gets.chomp.upcase
  print "Enter the quantity of shares to buy: "
  stock_quantity = gets.chomp.to_i
  @brokerage.clients[client_name].buy_stock(client_name, stock_symbol, stock_quantity, portfolio_name)
end

def sell_stock_for_client
  puts "HELP CLIENT SELL STOCK"
  print "Name of client (existing): "
  client_name = gets.chomp.split.map(&:capitalize).join(" ")
#  puts @brokerage.client(client_name) # test
  print "Name of portfolio (existing): "
  portfolio_name = gets.chomp.split.map(&:capitalize).join(" ")
  print "Enter the stock symbol: "
  stock_symbol = gets.chomp.upcase
  print "Enter the quantity of shares to sell: "
  stock_quantity = gets.chomp.to_i
  @brokerage.clients[client_name].sell_stock(client_name, stock_symbol, stock_quantity, portfolio_name)
end

def list_client_portfolios #wip
  puts "LIST CLIENT PORTFOLIOS WITH VALUES AND BALANCES"
  print "Name of client (existing): "
  client_name = gets.chomp.split.map(&:capitalize).join(" ")
#  puts @brokerage.client(client_name) # test
  print "Name of portfolio to list: "
  portfolio_name = gets.chomp.split.map(&:capitalize).join(" ")
  puts @brokerage.clients[client_name].portfolios[portfolio_name]
end

def list_stocks_in_portfolio
  puts "LIST STOCKS IN PORTFOLIO"
  print "Name of client (existing): "
  client_name = gets.chomp.split.map(&:capitalize).join(" ")
#  puts @brokerage.client(client_name) # test
  print "Name of portfolio to list: "
  portfolio_name = gets.chomp.split.map(&:capitalize).join(" ")
  puts @brokerage.clients[client_name].portfolios[portfolio_name]
end

def list_clients
  puts "LIST EXISTING CLIENTS OF #{@brokerage.name.upcase}:"
  @brokerage.clients.each { |key, value| puts key }
end