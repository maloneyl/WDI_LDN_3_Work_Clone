class Brokerage

  attr_accessor :name, :clients

  def initialize(name)
    @name = name
    @clients = {}
  end

  def add_client(client_name, balance)
    @clients[client_name] = Client.new(client_name, balance)
    puts "NEW CLIENT ACCOUNT CREATED: #{client_name}, with a balance of $#{balance}"
  end

  # find a client with the name
  # client should use hashes instead of arrays
  def client(name)
    client_to_find = name
    @clients.find {|key, value| key == client_to_find }   
  end

end


# Brokerage is our main class, master super class
# one of the properties is clients (a hash of client name and balance)
# client will then have a proprerty of portfolio
# portfolio will then have a property of stocks