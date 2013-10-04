class Client

  attr_accessor :name, :age, :number_of_children, :number_of_pets

  def initialize(name, age, number_of_children, number_of_pets) # note to self: number of pets might change
    @name = name
    @age = age
    @number_of_children = number_of_children
    @number_of_pets = number_of_pets # this might change if client adopts/'returns' a pet
    return 
  end

  def to_s
    puts "#{@name}, #{age}, has #{number_of_children} child(ren) and #{number_of_pets} pet(s)."
  end

end
