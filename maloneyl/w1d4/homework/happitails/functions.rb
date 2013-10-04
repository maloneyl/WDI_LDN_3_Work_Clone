require 'pry'
require 'pry-byebug'

require_relative 'animal'
require_relative 'client'
require_relative 'shelter'

def menu

  puts `clear` # so it's more like entering a menu
  # draw menu options then do a gets.chomp
  puts "What would you like to do? Choose by number:"
  puts "1. Display all animals"
  puts "2. Display all clients"
  puts "3. Create an animal"
  puts "4. Create a client"
  puts "5. Help a client adopt an animal"
  puts "6. Help a client put an animal up for adoption"
  to_do = gets.chomp
  puts ""

  case to_do
  when "1" then $shelter.display_animals # this is in shelter.rb
  when "2" then $shelter.display_clients # this is in shelter.rb
  when "3" then create_animal
  when "4" then create_client
  when "5" then adopt_animal
  when "6" then return_animal
  else exit
  end

end

def create_animal
  # prompt for attributes and then add to animals hash in $shelter
  # key is best as the name of the animal as a symbol
  puts "NEW ANIMAL REGISTRATION"
  puts "Name:"
  animal_name = gets.chomp
  puts "Age:"
  animal_age = gets.chomp
  puts "Gender (male/female):"
  animal_gender = gets.chomp.downcase
  puts "Species (dog, cat, etc.):"
  animal_species = gets.chomp.downcase
  puts "Favorite toys (separate each with commma):"
  animal_toys = gets.chomp.split(",")
  animal_owner = $shelter.name
  $shelter.animals[animal_name.to_sym] = Animal.new(animal_name, animal_age, animal_gender, animal_species, animal_toys, animal_owner)
  binding.pry
end

def create_client
  puts "NEW CLIENT REGISTRATION"
  puts "Name:"
  client_name = gets.chomp
  puts "Age:"
  client_age = gets.chomp
  puts "Number of children:"
  client_number_of_children = gets.chomp
  puts "Number of pets:"
  client_number_of_pets = gets.chomp
  $shelter.clients[client_name.to_sym] = Client.new(client_name, client_age, client_number_of_children, client_number_of_pets)
end

def adopt_animal
  # show available animals for client to choose from
  $shelter.display_animals
  puts "Which animal would you like to adopt? Enter its name:"
  animal_adopted = gets.chomp
  # animal chosen is then removed from the list of available animals
  $shelter.animals.delete(animal_adopted.to_sym)
  $shelter.display_animals
end

def return_animal # for clients to put an animal up for adoption
  # ask 
end

