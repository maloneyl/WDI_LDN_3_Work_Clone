require_relative "talkable" # this must be up here because person and dog both require it so Ruby must have already read talkable beforehand
require_relative "mammal"
require_relative "person"
require_relative "dog"

betty = Person.new
betty.say("hello")

ruff = Dog.new
ruff.shout("woof")