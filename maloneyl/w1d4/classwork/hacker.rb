require 'pry'

# class of the class named Class
# class Hacker

#   FIRST_NAME = "M" # constants are always in capitals

# #  attr_accessor :first_name
#   attr_reader :first_name, :last_name, :age
# #  attr_writer :age

#   # all methods below are instance methods

#   def initialize first_name, last_name, age
#     @first_name = first_name
#     @last_name = last_name
#     @age = age
#   end

#   # this funciton is essentially attr_writer :first_name, :last_name
# #  def set_name first_name, last_name
# #    @first_name = first_name
# #    @last_name = last_name
# #  end

#   # this function is essentially attr_reader :name
# #  def get_name
# #    puts @name
# #  end

#   def job
#     puts "developer"
#   end

#   def say_something say_what
#     puts "is saying #{say_what}"
#   end

#   def to_s
#     puts "I am the method to_s inside the Hacker class"
#   end

#   # here is a class method, marked by self.
#   def self.job
#     puts "developer but in a class method"
#   end

#   def self.create first_name, last_name, age
#     self.new(first_name, last_name, age) if age_verification(age) # this refers to self.age_verification because that's the context self.create is in
#   end

#   def self.age_verification age
#     age >= 21 # note there's no @ here because it's not an INSTANCE var anymore
#   end

# #  def age_verification age # this is the instance version
# #    @age >= 21 # this is the instance ersion
# #  end

# end

# person = Hacker.new

class A
  attr_accessor :random_property
  def self.x
    puts "I am a class method from class A"
  end

  def y first_argument
    puts "I am an instance method from class A"
  end
end

class B < A
  def y
    puts "I am an instance method from class B"
  super("I am an argument from the parent method")
  end
end

binding.pry








