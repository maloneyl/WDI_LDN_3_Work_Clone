require 'pry'
require 'pry-byebug'
require 'yahoofinance'

require_relative 'brokerage'
require_relative 'client'
require_relative 'functions'

#binding.pry

@brokerage = Brokerage.new("Goldman Assembly") # data.rb should attach this brokeage

# should call function to fake data here
require_relative 'data'

# stuff showing menu
user_input = ""

while user_input != "q"
  puts "\nWelcome, #{@brokerage.name} Staff! What would you like to do?\n\n"
  puts "1. Create a new client account"
  puts "2. Create a portfolio for a client account"
  puts "3. Help a client buy stocks at market rate"
  puts "4. Help a client sell stocks at market rate"
  puts "5. List all client portfolios and their values and account balances"
  puts "6. List all stocks in a portfolio"
  puts "7. List all clients"
  puts "Press q to quit"
  user_input = gets.chomp.strip
  puts ""
  
  case user_input
  when "1" then create_client
  when "2" then create_portfolio
  when "3" then buy_stock_for_client
  when "4" then sell_stock_for_client
  when "5" then list_client_portfolios
  when "6" then list_stocks_in_portfolio
  when "7" then list_clients
  when "q" then exit
  end  
end

# main is the file we run to launch the application
# this file should contain the logic of the menu
# and call the function depending on user choice

# the 7 options are:
# Create an account for client (name, balance),
# Every client can create multiple portfolios,
# A client can buy stocks at market rate; these stocks will be added to a portfolio and the purchase amount subtracted from cash. (You cannot go to a negative cash balance),
# A client can sell a stock. The proceeds go into his account,
# List all client portfolios and their values (each portfolio value and sum of portfolio values) and the account balance,
# List all stocks in a portfolio,
# List all clients.