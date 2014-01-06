# Brief says:
# The shelter should display all the clients.
# The shelter should display all the animals.

require_relative 'animal'
require_relative 'client'
require_relative 'data'

class Shelter

  # think about what you'll need for a business
  # start with _accessor; figure out if anything should be read- or write-only later
  attr_accessor :name, :address, :animals, :clients # the :stuff are arguments to the attr_accessor function; the arguments can be symbols or strings
  # because it's outside def and inside class, Ruby will get to attr_accessor and write these set and get methods for us even before we do anything

  def initialize(name, address) # name and address will be gone after they're passed
    @name = name # so you need an instance variable to store stuff from above
    @address = address
    @animals = {} # nothing is passed in now but we still need it for later
    @clients = {}
  end

  def display_animals
    puts "These animals are currently in our shelter and available for adoption:"
    @animals.each { |key, value| puts value }
  end

  def display_clients
    puts "Here is our list of clients:"
    @clients.each { |key, value| puts value }
  end

  def to_s
    "#{@name} Shelter at #{@address}"
  end

end
