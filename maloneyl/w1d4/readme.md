COMMENTS & QUESTIONS
======================

Blockers:

- A lot of trouble with jumping from files, methods, etc.
- How is the main menu supposed to loop? Is there a pause?
- Not sure why instances like " #<Animal:0x007fb053ab5878" keep getting puts-ed as well...

CLASS NOTES BELOW
======================

0. HOMEWORK REVIEW

one possible way:
have a hash with a key of all stations in terms of distance from Union Square, e.g. L1: 2, N8: 1, etc. 

*** AHA! MOMENT ***
you can push an array into a hash so that you don't need to map the line-and-station manually…
e.g. 
n = [ "station1", "station2", … ]
l = [ "stationA", "stationB", … ]
mta[:n] = n
mta[:l] = l
so then you can just get the user to give you the line and you turn that input into a symbol to then grab the array (line required) simply by mta[user_input_turned_symbol]
***********************

1. RUBY - OBJECT-ORIENTED PROGRAMMING

functional programming
= write a script that's lots of lines. defining variables and then methods. then call methods.
and that's what we've been doing

object-oriented programming
= create oriented objects with methods and properties

an object is an instance of a class

class names should be in CamelCaseLikeThis

instance
= create an object representing a particular class
= has a beginning and an end. you create it, then you delete it.
AS OPPOSED TO
a class is always inside your ruby environment. this class will always be in the environment waiting to be called.
in pry, you'll see a presenting class highlighted and underlined

create an object by
NameOfClass.new
[3] pry(main)> person = Hacker.new # this newly created object person is an instance of the class Hacker
=> #<Hacker:0x007fa6f8aee0b0> # this shows that it's an instance of the class Hacker
[6] pry(main)> person.class
=> Hacker
[5] pry(main)> Hacker.class
=> Class # think of it as a native Ruby class
[X] pry(main)> Class.class
=> Class # haha

but if you leave that session and then relaunch the program, you'll find that Hacker still exists while person is not there anymore, because person was just an instance
[1] pry(main)> Hacker
=> Hacker
[2] pry(main)> person
NameError: undefined local variable or method `person' for main:Object

------
class Hacker
  def job
     puts "developer"
  end
end
-----
the method here (job) only applies to an instance of the class. if you don't have an instance to call the method on, the method doesn't exist. i.e., you can't call Hacker.job, but you can call person.job once you have a person instantiated.

monkey-patching
= overriding a native class, e.g. its method (like if you want .to_s to do something more specific than the default)

each object has a parent class that it inherits from
[3] pry(main)> some_hash = {}
=> {}
[4] pry(main)> some_hash.class
=> Hash
[5] pry(main)> some_hash.class.class
=> Class

the child inherits from the parent, but if they both have a method of the same name and you call that method on the child, the child version of the method will override

parent -> child -> object

when you create an instance, Ruby by default calls the method .to_s to return the value of the instantiation
because every class inherits from Ruby's overall Class, and Class has .to_s defined already, your own class will be able to use .to_s as default:
[1] pry(main)> person = Hacker.new
=> #<Hacker:0x007fcd2c26fc90>
[2] pry(main)> person.to_s
=> "#<Hacker:0x007fcd2c26fc90>"
you can define your own .to_s inside your class if you want, e.g.
-------------
class Hacker

  def to_s
    puts "I am the method to_s inside the Hacker class"
  end

end
-------------
[1] pry(main)> person = Hacker.new
=> #<Hacker:0x007fc229b7c5f8>
[2] pry(main)> person.to_s
I am the method to_s inside the Hacker class

constructor
you can define your own initializer too (def initialize), usually defined at the beginning by convention, and yes, it must be called and spelt initialize in order to be associated with .new
[1] pry(main)> person = Hacker.new
I'm the initializer of the Hacker class
=> #<Hacker:0x007fb898b03558>

the initialize method can take arguments too, like any other method:
--------------
  def initialize name
    puts "I'm #{name}"
  end
--------------
[2] pry(main)> person = Hacker.new "Baloney"
I'm Baloney

@variable
= an instance variable begins with an @
= everything in the class has access to this instance variable

[1] pry(main)> person
=> #<Hacker:0x007ff98c096428 @name="Maloney">
a property in the instance of the class Hacker

you can use show-method in pry to inspect stuff:
[3] pry(main)> show-method person.set_name
*****
From: hacker.rb @ line 6:
Owner: Hacker
Visibility: public
Number of lines: 3

def set_name name
  @name = name
end
*****

that's a setter
you have getters too:
-------
  def get_name
    puts @name
  end
-------

attribute accessors
= automatically create get and set functions with:
attr_reader :symbol
attr_writer :symbol
note: you always pass symbols to the attr_reader and attr_writer

attr_reader :first_name, :last_name
-> with the attribute reader, we're getting able to read @first_name and @last_name outside of the method

[2] pry(main)> person.set_name "Maloney", "Baloney"
=> "Baloney"
because the default value to return is the last value given; in our function, that means last_name
[5] pry(main)> person.first_name # now you can access this property as if it's a method
=> "Maloney"

classes are made up of methods and properties

attr_writer sets, attr_reader gets
sometimes you want to make something read-only or write-only
but if you want to make it read-and-write-able, simply combine attr_reader and attr_writer with:
attr_accessor

if you add .self as the keyword in a method name (e.g. def self.job), you can then use that method as a class method. otherwise, it's only an instance method (i.e. can be called on an instance only and not a class)
-----------
  def self.job
    puts "developer but in a class method"
  end
----------
[1] pry(main)> Hacker.job
developer but in a class method

a common use case for class methods is when you deal with databases and want to filter something… things will make more sense later

---------
  def self.create age
    self.new if age_verification(age) # this refers to self.age_verification because that's the context self.create is in
  end

  def self.age_verification age
    age >= 21 # note there's no @ here because it's not an INSTANT var anymore
  end

  def age_verification age # this is the instance version
    @age >= 21 # this is the instance version
  end
----------
[1] pry(main)> Hacker.create 12 
=> nil # didn't bother creating an instance
[2] pry(main)> Hacker.create 22
=> #<Hacker:0x007fbeaa342bf8> # ok

again, be mindful of the parameters/arguments needed when and where, e.g.
----------
  def initialize first_name, last_name, age
    @first_name = first_name
    @last_name = last_name
    @age = age
  end

  def self.create first_name, last_name, age
    self.new(first_name, last_name, age) if age_verification(age)
  end
----------
[2] pry(main)> Hacker.create("Maloney", "Baloney", 23)
=> #<Hacker:0x007fb6c9a64190 @age=23, @first_name="Maloney", @last_name="Baloney">
BEHIND THE SCENES. the 23 first gets passed to the self.create's age, then its age_verification(age)'s age, then self.age_verification's age, then if true it goes back up to self.new's age

possible use case of class methods, e.g. in a blog, when you need to filter something
-----------------
class Post
  attr_accessor :title, :content, :author

  def self.search search_term
    DB.find_related_post search_term # fake, just for example
  end
end 

posts = Posts.search "Ruby is cool" # then it'll return all related instances
-----------------

you can create class constants
FIRST_NAME = "M" # constants are always in capitals
[1] pry(main)> Hacker::FIRST_NAME # can call it with double-colon (double-colon also means child-of)
=> "M"

allocate: allow you to build custom constructors for your objects
[2] pry(main)> Hacker.allocate
=> #<Hacker:0x007f9462197b68>

***********************

2. INHERITANCE

INHERITANCE

to create a class to inherit from some other class:
-------
class ClassName < ParentClassName
end
-------
where ClassName inherits from ParentClassName

! SUBMLIME shortcut !
select stuff, cmd+/, then everything will be commented out

-------------------
class A
  attr_accessor :random_property
  def self.x
    puts "I am a class method from class A"
  end

  def y
    puts "I am an instance method from class A"
  end
end

class B < A
end
-------------------
now, on B and B's instances, you can use A's class method, A's instance method, and A's attribute:
[1] pry(main)> b = B.new
=> #<B:0x007f8bb424a828>
[2] pry(main)> b.y
I am an instance method from class A
=> nil
[4] pry(main)> B.x
I am a class method from class A
[X] pry(main)> b.random_property = "I am actually interacting with an attribute in the class a"
=> "I am actually interacting with an attribute in the class a"

BUT if you change the code to:
-------------------
class B < A
  def y
    puts "I am an instance method from class B"
  end
end
------------------
now B's version of method y will override A's version of method y
[2] pry(main)> b.y
I am an instance method from class B

and let's change the code even more:
-------------------
class B < A
  def y
    puts "I am an instance method from class B"
    super
  end
end
------------------
where "super" gives you the parent version, i.e. A's y method here
[2] pry(main)> b.y
I am an instance method from class B
I am an instance method from class A
=> nil
a common use case is when you initialize the child from the parent, where you'll need something you already got in the parent and do something extra in the child

Ruby does single inheritance only: a class can only inherit from one other class, not from multiple classes
but you can (and you do) have a class inheriting from a class inheriting from a class inheriting from a class…:
[3] pry(main)> B.ancestors
=> [B, A, Object, PP::ObjectMixin, Kernel, BasicObject]

Kernel is a standard object in irb
try Kernel.methods to see all that stuff that we normally use…

use case for inheritance:
class Animal (where you define common things like 1 head, 4 legs, popular as pets)
then get offsprings: class Dog, class Cat

***********************

3. MARKDOWN WITH MOU

Refer to that Mou file.

***********************

4. GIT REVIEW

we should merge the previous day's branch with master before we start the current day's homework
but before that, we should make sure that the current day's stuff has been committed to the current day's branch first

current day is w1d4
we've been working from the w1d4-maloneyl branch
cd back to WDI_LDN_3_Work
git status (should say nothing to commit, but maloneyl/w1d4/ untracked)
git add maloneyl/w1d4
git commit -m "getting w1d4's folder up as of almost-end-of-class"
git status (should say nothing to commit, working directory clean)
git checkout master
git merge w1d3-maloneyl

***********************

5. HOMEWORK

Ruby convention for naming file that stores a class:
for class BigDog, name it big_dog.rb

have one file for each class

main.rb is the main, starting-point one you run from

data.rb 

you can 'require' things that are in your own files and essentially copy and paste, e.g.
require_relative 'shelter'
what you're passing to it is the relative address, so if the file required is in the same directory, just type the filename

$ denotes a global variable

when you start coding, start with attr_accessor because in the beginning you won't know whether something should be read-only or write-only, so just write code that does what you want first and refactor later

you can store info like this:
$shelter.animals = { :fido  => Animal.new(), :shep => Animal.new() }
or
$shelter.animals = { fido: Animal.new(), shep: Animal.new() }
OR
$shelter.animals = [ Animal.new, Animal.new ]
BUT if you use an array, you'll have a harder time finding an animal by name with something like this:
$shelter.animals.find { |record| record.name == "Fido" }
and the code above will take a long time to find if the database is very large
so go with the hash method!

toys = %w(ball bone chew-toy)
=> ["ball", "bone", "chew-toy"]
toys.join(', ')

