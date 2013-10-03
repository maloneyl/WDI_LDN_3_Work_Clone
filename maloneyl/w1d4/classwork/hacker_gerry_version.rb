require "pry"


# # child of the class called Class
# # when a new instance of the class Hacker is created, 
# # ruby by_default calls the method to_s to return the value of the instantiation

# class Hacker
#  FIRST_NAME = "Gerry"
#  #attr_accessor 
#  #attr_writer 
  

#  def initialize first_name, last_name, age
#    @first_name = first_name
#    @last_name = last_name
#    @age = age
#  end

#  def self.create first_name, last_name, age
#    self.new(first_name, last_name, age) if age_verification(age)
#  end


#  def self.age_verification age
#    age >= 21
#  end

#  #instance method
#  def job
#    puts "developer"
#  end

#  #class method
#  def self.job
#    puts "developer but in a class method"
#  end

#  def say_something say_what
#    puts "is saying #{say_what}"
#  end

#  def to_s
#    puts "I'm the method to_s inside the Hacker class"
#  end
# end

# binding.pry

class A
  attr_accessor :random_property

  def self.x
    puts "i am a class method from class A"
  end

  def y first_argument
    puts "I am an instance method from class A"
  end
end

class B < A
  def y
    puts "I am an instance method from class B"
    super("an_argument fot the parent method")
  end
end

binding.pry

class InheritedClass < BaseClass

end