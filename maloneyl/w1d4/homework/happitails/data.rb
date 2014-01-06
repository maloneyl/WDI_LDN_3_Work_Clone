require_relative 'shelter' # require something from your own file
require_relative 'client'
require_relative 'animal'

$shelter = Shelter.new('HappiTails', '1 Main Street, Everytown') # $ denotes a global variable

# add initial data of clients
$shelter.clients[:Simon] = Client.new('Simon', 29, 0, 1)
$shelter.clients[:Andrew] = Client.new('Andrew', 41, 2, 0)
$shelter.clients[:Dawn] = Client.new('Dawn', 48, 2, 1)
$shelter.clients[:Sue] = Client.new('Sue', 31, 0, 3)

# add initial data of animals
$shelter.animals[:Riley] = Animal.new('Riley', 10, 'male', 'dog', ['balls', 'tossing toys'], $shelter.name)
$shelter.animals[:Tucker] = Animal.new('Tucker', 8, 'male', 'dog', ['light toys', 'ropes'], $shelter.name)
$shelter.animals[:Mimi] = Animal.new('Mimi', 5, 'female', 'cat', ['balls', 'catnip toys', 'feather toys'], $shelter.name)
$shelter.animals[:Tigger] = Animal.new('Tigger', 7, 'male', 'cat', ['animal toys', 'light toys'], $shelter.name)

# $shelter.animals[:riley] = Animal.new('Riley', 10, :m, :dog, [:balls, :chew_toys, :squeak_toys])
# $shelter.animals[:tucker] = Animal.new('Tucker', 8, :m, :dog, [:light_toys, :tossing_toys, :ropes])
# $shelter.animals[:mimi] = Animal.new('Mimi', 5, :f, :cat, [:balls, :catnip_toys, :feather_toys])
# $shelter.animals[:tigger] = Animal.new('Tigger', 7, :m, :cat, [:animal_toys, :catnip_toys, :light_toys]# )
