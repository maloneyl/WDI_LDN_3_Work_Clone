# Brief says:
# An animal should have a name.
# An animal should have an age.
# An animal should have a gender.
# An animal should have a species.
# An animal can have multiple toys.

class Animal

  attr_accessor :name, :age, :gender, :species, :toys, :adopt_status

  def initialize(name, age, gender, species, toys, owner)
    @name = name
    @age = age
    @gender = gender
    @species = species
    @toys = toys # array is fine because we won't need to search for toys
    @owner = owner
    return @name, @age, @gender, @species, toys
  end

  def to_s
    puts "#{@name} is a #{@age}-year-old #{@gender} #{species} that loves #{toys.join(", ")}."
#    puts "#{@name} is a #{@age}-year-old #{@gender} #{species} that loves #{toys.join(", ")}."
  end

end
