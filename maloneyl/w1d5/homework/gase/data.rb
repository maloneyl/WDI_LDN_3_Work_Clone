require_relative 'client'

# Instantiate clients. Insert them into the brokerage's clients hash
@brokerage.clients["Bob Barley"] = Client.new("Bob Barley", 1_500_000)
@brokerage.clients["Estefan Colberto"] = Client.new("Estefan Colberto", 3_000_000)
@brokerage.clients["Johnny Stewart"] = Client.new("Johnny Stewart", 4_500_000)

@brokerage.clients["Bob Barley"].portfolios = { "Tech" => {AAPL: 10, GOOG: 20}, "Music" => {ARTD: 30, DLB: 40} }
@brokerage.clients["Estefan Colberto"].portfolios = { "Tech" => {FB: 50, GOOG: 20}, "Entertainment" => {VIA: 10, DIS: 20} }
@brokerage.clients["Johnny Stewart"].portfolios = { "Finance" => {HBC: 20, BARC: 40}, "Entertainment" => {VIA: 20, TWX: 10} }


# @brokerage.clients["Bob Barley"].portfolios = { "Tech" => ["AAPL", "GOOG"], "Music" => ["ARTD", "DLB"] }
# @brokerage.clients["Estefan Colberto"].portfolios = { "Tech" => ["FB", "GOOG"], "Entertainment" => ["VIA", "DIS"] }
# @brokerage.clients["Johnny Stewart"].portfolios = { "Finance" => ["HBC", "BARC"], "Entertainment" => ["VIA", "TWX"] }

# fake portfolio, fake clients, fake stocks
# just to give yourself initial data to test your program


# X has X portfolios worth $X with X shares of X stocks

# Client: ___
# Portfolio: Tech, Energy, Fashion
# Purchased X shares of NAME (SYMBOL) worth #XXXX