COMMENTS (BLOCKERS, SUCCESSES & QUESTIONS AFTER HOMEWORK)
=========================================================

- Wondered how the functions in each file are supposed to be different or work together
- Not entirely sure when/where to use/put require_relative 
- Wondered the setup of fake data and of portfolios

CLASS NOTES
=========================================================

0. HOMEWORK REVIEW

initialize is a special method

instance variables = variables that will still be stored (and available to the class) after the method is done; they live as far as the objects lives

we have variables in scopes so that there's no confusion
e.g. animal name, client name 
won't overlap
that's why you don't use global variables liberally. it's not good practice. because of naming conflict.

[3] pry(main)> class Person
[3] pry(main)*   def initialize(name)
[3] pry(main)*     @name = name
[3] pry(main)*   end  
[3] pry(main)* end  
=> nil
[4] pry(main)> jon = Person.new("Jon")
=> #<Person:0x007fbf6134ac60 @name="Jon">
[5] pry(main)> ls jon
instance variables: @name
[6] pry(main)> ls Person

[7] pry(main)> 
-> there's no instance variable in Person (the class)

class method examples:
User.count
User.find_by_name "jon"

remember:
def self.something => class method; note that it doesn't mean that this class method automagically has superpower to do something on all the instances within the class
def something => instance method

puts
-> default behavior is the to_s

print
-> ..

p
-> use inspect method (standard class method all objects would have), display string with quote marks and with new line, return the string,

when you do 
------
  attr_accessor :name, :address, :animals, :clients
------
all the :stuff are actually arguments to the attr_accessor function that Ruby writes for us!
the arguments can be symbols or strings
because it's outside def and inside class, Ruby will get to attr_accessor and write set and get methods for us (so that we don't have to do "def name; @name; end" and "def name=(name); @name=name; end" ourselves)
this is dynamic programming

1. Ruby is single inheritance

class Hacker < Person
means that Hacker class inherits from Person class

what if you want Hacker to inherit from RockStar class too?
----
class Hacker < Person
  include RockStar
----
where RockStar is a module

modules
= general libraries of code

for instance, if you have the module Talkable

you can have 
Mammal -> Human, Dog, Koala; and only Human and Dog mix in Talkable
Machine -> MacBook, Something; and have both mix in Talkable

module Talkable
  def say(str)
    puts str
  end

you inherit from one class only
you mix in as many modules as you want

so you can have
----
class Dog < Mammal
  include Talkable 
end

d = Dog.new
d.say "woof"
----
-> "woof"

let's say the module Talkable also has this module method:
----------
  def self.mute_all # or def Talkable.mute_all
  end
----------
while in your class Dog:
``````
  include Talkable
  include Foo
  def some_method
     Talkable.mute_all # this means you can potentially include Foo even if Foo also has a mute_all, no conflict (this is called name spacing)
  end
  def woof
    say(woof) # ** this calls Talkable's say method; you can also put self.say(woof)
  end
```````
and you'll call it with d.some_method
re: ** above, if Foo also has a say method, because Foo is included after Talkable, so Foo's version of say method will override

in your main.rb, you should require_relative "takable" before require_relative "person" and require_relative "dog" if Person and/or Dog include Talkable. otherwise, Ruby will get to Person's or Dog's code and wonder "what the heck is this Talkable you want me to include? error"

lib conventionally means library, the good stuff
puts modules in it, things you normally use

create modules when you have methods you think you could reuse for something else
e.g. code that calculates a birthday can be used in a Person, Dog, GA_Campus, etc.

Ruby has built-in modules too, e.g. Comparable (which helps you sort things… you have the def in the code though)
no need to tell Ruby where to require built-in modules; Ruby knows

more examples on modules
https://gist.github.com/odlp/6825538

get modules from a module
::

2. WEEKLY REVIEW

https://docs.google.com/a/generalassemb.ly/document/d/1DEQTIMhUS3Ivev9HYHfLTXneEl0epRrMe9qN7skj4A0/e...

git init DIR
-> creates .git in your directory

git add

git commit
commit as frequently as possible! so that you can track the whole evolution

git checkout COMMIT_ID
-> yes, you can checkout a commit too by specifying the ID (find in git log)

usually HEAD is master's latest commit (also what the prompt means by just master)
when you do checkout, that moves the HEAD

when you're branching, be mindful of where it's branched from. its log will only include the history of where it's branched from and what it's committed since. what's separate since is still, well, separate.
and that's why eventually you merge (or rebase…we'll learn more later)

git commit -am ""
-> -am = add and commit at the same time; works if it's a file you've tracked 

when git means there's nothing to commit, there really is nothing to commit
every time you commit, git will change the whole repository for you

git remote update
-> 

origin can be checked by
git remove -v

origin/master
= master branch of the origin (remote)

when git says "your branch is ahead of origin/master by 1 commit"
that means your local version is 1 commit ahead of what's up on github's master, because you've been doing more stuff locally since the last push

git will think a repo is different even if there's only 1 commit's difference
so if you've recommitted something in your local version and then try to push to github, github might say it's different
if you're sure it's the same and what you want, you can tell it to git push -f origin master (where -f means force)

RUBY

(5..10).inject { |sum, n| puts sum + n }
-> sum elements in an array; sum is always returned, then you have another thing that's passed as the n
the first time it runs, it's 0+5, then 5+6, then 11+7, then 18+8...

['one', 'two', 'three'].inject { |text, word| text + word }
=> "onetwothree"

you can pass one or two thing into an .each method for a hash depending on whether you want to get the key-and-value as a pair or you want to get key and value as separate:
=> {:one=>1, :two=>2, :three=>3}
[5] pry(main)> { one: 1, two: 2, three: 3 }.each { |one| p one }
[:one, 1]
[:two, 2]
[:three, 3]
[4] pry(main)> { one: 1, two: 2, three: 3 }.each { |one, two| p one, two }
:one
1
:two
2
:three
3

remember, puts' default return value is nil

3. HOMEWORK

GASE
General Assembly Stock Exchange

[1] pry(main)> require "yahoofinance"
=> true
[2] pry(main)> YahooFinance
=> YahooFinance
[3] pry(main)> YahooFinance::get_standard_quotes("AAPL")
=> {"AAPL"=>
….
….
@lastTrade=480.7, # this is the real-time stock price
….
}
[4] pry(main)> YahooFinance::get_standard_quotes("AAPL")["AAPL"].lastTrade
=> 480.63
[5] pry(main)> YahooFinance::get_standard_quotes("AAPL")["AAPL"].lastTrade
=> 480.61