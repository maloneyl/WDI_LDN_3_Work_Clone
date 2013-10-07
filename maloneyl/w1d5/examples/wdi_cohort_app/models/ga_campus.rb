require_relative "../lib/acts_as_ageable"

class GaCampus
  
  include ActsAsAgeable
  include Comparable
  
  attr_accessor :city, :dob, :cohorts
  
  def initialize(city, dob)
    @city    = city
    @dob     = ActsAsAgeable.parse_date_string dob
    @cohorts = []
  end
 
  def <=> (other)
    self.city <=> other.city
  end
  
  def to_s
    str = "General Assembly #{@city} is #{age} years old"
    str += " *** BIRTHDAY TODAY ***" if birthday_today?
    str
  end
  
end