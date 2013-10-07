require_relative "../lib/acts_as_ageable"

class Person

  include ActsAsAgeable
  include Comparable # built-in Ruby module for you to sort things, no need to tell Ruby where to require it

  attr_accessor :name, :dob

  def initialize(name, dob)
    @name = name
    @dob  = ActsAsAgeable.parse_date_string dob
  end

  def to_s
    str = "#{name} is a #{self.class}, and is #{age} years old."
    str += " *** BIRTHDAY TODAY ***" if birthday_today?
    str
  end

  def <=> (other) # Comparable expects you to define 
    self.name <=> other.name
  end

end