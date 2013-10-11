require "pry"

#------------------------------------------------
# SPECIFY things here (backlog)
#
# TODO: add Person class
# TODO: add Country class
# TODO: add sub-class Pond
# TODO: add sub-class Continent
# TODO: make Country sub-class of Continent


#------------------------------------------------
# IMPLEMENT modules here

module UniversalFormatter
  def titleiz(string)
    string.split(" ").map do |word|
      word.capitalize
    end.join(" ")
  end
end

#------------------------------------------------
# IMPLEMENT classes here

class Planet
  attr_reader :name
  attr_accessor :continents, :lakes

  def initialize(planet_name)
      @name = planet_name
      @continents = []
      @lakes = []
  end

  def print_num_continents
    puts @continents.size.to_s
  end

  def print_lakes
    @lakes.each do |lake|
      puts lake.name
    end
  end
end

class Moon < Planet
end


class Continent
  attr_reader :name
  attr_accessor :population_density

  def initialize(name, population_density)
    @name = name
    @population_density = population_density
  end

end

class Lake
  attr_reader :name, :type
  attr_accessor :temp

  include UniversalFormatter

  def initialize(n, t, temperature)
    @name = n
    @type = t
    @temp = temperature
  end

  def describe
    puts titleiz "Lake #{name} is #{type} and is #{temp} degrees C"
  end

end

class Pond < Lake
  attr_accessor :no_frogs

  def initialize(name, type, temperature, no_of_frogs)
    result = super(name, type, temperature)
    @no_frogs= no_of_frogs
  end
end

#------------------------------------------------
# USE classes here



earth = Planet.new "Earth"

puts "Jon has created #{earth.class.to_s.downcase} #{earth.name}"

p Planet.ancestors

winnas_moon = Moon.new "Winna's Moon"
winnas_moon.print_lakes

sharifs_lake = Lake.new "Victoria", "Natural", 28.0
# puts "Lake #{sharifs_lake.name} is #{sharifs_lake.type} and is #{sharifs_lake.temp} degrees C"
sharifs_lake.describe

some_continent = Continent.new("Maloney's Continent", 1)

earth.continents << some_continent
earth.print_num_continents

jonny_lake = Lake.new "lake jon", "man made", 22.0

earth.lakes << jonny_lake << sharifs_lake

earth.print_lakes

