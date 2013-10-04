# HappiTails Animal Shelter

## Brief

The client is the manager at HappiTails animal shelter. She needs an app that can manage the shelter by storing and manipulating information about clients and animals.

Your boss has asked you to develop a prototype app using an Object Oriented approach. The app should load sample data when it starts up, while also allowing the user to add new data via a series of command-line prompts.

## Specification

After sitting down with the client, the following spec was agreed:

#####Object Specs:
- Animal:
  - An animal should have a name.
	- An animal should have an age.
	- An animal should have a gender.
	- An animal should have a species.
	- An animal can have multiple toys.

- Client:
	- A client should have a name.
	- A client should have a number of children.
	- A client should have an age.
	- A client should have a number of pets.

- Shelter:
	- The shelter should display all the clients.
	- The shelter should display all the animals.

- Relationships:
	- A client should be able to adopt an animal.
	- A client should be able to put an animal up for adoption

## Hints and Tips

Each object is going to need some basics. For example, a skeleton of `animal.rb` might look like this:

```
class Animal

  # Set up accessors and mutators for the attributes of an Animal
  # attr_accessor sets up both for you
  attr_accessor :name, :age, :gender, :species, :toys

  # Used when creating a new animal.
  #   Example:
  #       Animal.new('Timmy', 4, 'male', 'toad')
  def initialize(name, age, gender, species)

  end

  # When we display the animal using puts or print, the
  #   to_s method is called to pretty print an Animal
  def to_s

  end
end
```

We're going to need similar files for `Client` and `Shelter` classes as well.

We're also going to need a main executable we can call e.g. `main.rb`. In order to keep `main.rb` relatively small and easy to understand, we can pull functions it call out into a separate `functions.rb` file. Similarly, we can setup our variables and handle data loading via a separate file, let's call it `data.rb`.

So create these files and start to flesh out their content. Completing the code in stages will make this easier. Consider using the following stages...


## Development Stages

#####Phase 1
- Shelter, Animal, and Client objects can be created

#####Phase 2
- New animals and clients can be added to the shelter

#####Phase 3
- When creating an animal or client, the user is prompted for information like names, gender etc.

#####Phase 4
- At start, the user is prompted with a menu of options:
    - display all animals
    - display all clients
    - create an animal
    - create a client
    - facilitate client adopts an animal
    - facilitate client puts an animal up for adoption
- After selecting from the menu the user is prompted through the entire process


## Student Notes

_Feel free to add notes here, and any comments on what you found challenging._
