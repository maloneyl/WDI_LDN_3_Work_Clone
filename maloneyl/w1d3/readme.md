COMMENTS (BLOCKERS, SUCCESSES & QUESTIONS AFTER HOMEWORK)
=========================================================

Successes:

- Solved the logic of the homework fairly quickly
- Still feeling great even when things got difficult
- Git is making more sense with every use 

Blockers/Questions:

- While I understand the concepts and methods discussed today, figuring out actual applciation of them still needs some work (and maybe just time). Classwork, for instance, was difficult as it involved using and combining quite a number of things.
- I'm sure there is shorter, better code for the homework, but haven't quite had the time tonight to work on it more. I keep thinking there's probably something I can do with merge, something that can be made into a method (but right now am not quite sure about how to best deal with contraints that come with local variables), whether a hash should be used instead of an array (why and how), etc.

****************

HOMEWORK: MTA

There are 3 subway lines:

The N line has the following stops:
Times Square, 
34th, 
28th, 
23rd, 
Union Square,
8th

The L line has the following stops:
8th, 
6th, 
Union Square, 
3rd,
1st 

The 6 line has the following stops:
Grand Central, 
33rd, 
28th, 
23rd, 
Union Square, 
Astor Place

All 3 subway lines intersect at Union Square, but there are no other intersection points.
(For example, this means the 28th stop on the N line is different than the 28th stop on the 6 line.)

You task is to write a Ruby program that will allow the user to calculate the length of its trip in the underground (i.e. the number of stops between any two given stations).

https://github.com/ga-students/WDI_LDN_3_Work/blob/master/Homework-assignments/w1d3.md

****************

CLASS NOTES BELOW
=========================================================

0. HOMEWORK REVIEW (INCL. GIT)

re: BMI calc
oh yeah, would be good to show what the number means…

re: starting up the calculator
could consider starting with "puts `clear`'" so that the user really enters into a program

re: validation user input
no need to worry for now :D can ignore whatever's not in the instructions...

when you don't need to use the value after, no need to bother storing it in a variable and could just do the calculation directly within the result line. fewer lines of code.

re: github
better to submit from the root folder (e.g. WDI_LDN_3_WORK instead of WDI_LDN_3_WORK > username > w1d2 > homework)

git remote -v
-> shows you what your remote is:
origin  git@github.com:maloneyl/WDI_LDN_3_Work.git (fetch)
origin  git@github.com:maloneyl/WDI_LDN_3_Work.git (push)

because git doesn't recognize empty folders, a developer's convention is to create a .gitkeep file within that otherwise-empty folder

when you're all done, your git status should have nothing to commit

so if you're done submitting w1d2-maloneyl and today is w1d3, get back out with
git checkout master
then create and switch to w1d3-maloneyl by
git checkout -b w1d3-maloneyl

****************

1. RUBY AND PRY

debugging: there are special tools to help!
e.g. Pry
gem install pry pry-byebug

ruby -v
-> show version of ruby

rbenv rehash
-> make ruby look for new binary (?) so that you can then find that new thing (pry) you installed 

now you can use pry! (and forget about irb)

with pry, you can cd into a string, e.g. cd "hello"
and if you then ls it, it'll list all the methods you can use on it (similar to how your normal shell would let you ls dir to list the files within the directory)

binding.pry
-> pause a program at that breakpoint and give you a snippet of the code

ls
-> show methods

can then check out all variables at that stage with ls -l:
pry(main)> ls -l
b = 2.0
a = 3.0
operation = "s"
result = nil

s
-> step through the code, so it'll go to whichever line its next step should be (e.g. if you're at add_something(a, b), the next step means where add_something is defined)
note: this would also include stuff related to some gem that's involved; press "f" of "finish" to get out of that

local variables
= only bound within the def-end 
note that you're normally just passing arguments into a method, so that the method gets its own variables and variable values

whereami
-> gets you back to the line you're at in the snippet

c
-> means continue

---SUBLIME TEXT 2---
alt+cmd+f
-> pull up replace all
------------------------------

----RELATED TO HOMEWORK YESTERDAY--------
buggy-calc.rb has that "is it an integer that the user is typing in?" check included:
    55: def contains_integer(str)
 => 56:   str.to_i.to_s == str
    57: end
------------------------------------------------------------------

when debugging, the line where the error occurs might not necessarily be the problem

****************

2. RUBY: ARRAYS

_
(as in underscore)
= shows last value

creating an array of strings: 2 possible ways:
[9] pry(main)> arr = ["foo", "bar", "baz"]
=> ["foo", "bar", "baz"]
[10] pry(main)> %w(foo bar baz)
=> ["foo", "bar", "baz"]
the delimiters surrounding the strings after %w don't even have to be parentheses, can be [] or something else that's not a special symbol

also different ways to get the size of the array:
[11] pry(main)> arr.length
=> 3
[12] pry(main)> arr.size
=> 3

creating a nested array:
[13] pry(main)> a1 = [1, 2, 3]
=> [1, 2, 3]
[14] pry(main)> a2 = [4, 5, 6]
=> [4, 5, 6]
[15] pry(main)> a3 = [a1, a2]
=> [[1, 2, 3], [4, 5, 6]]

indexes can be nested too:
[17] pry(main)> a3[0][1]
=> 2

indexes can start from the end too:
a1[-1]
=> 3

there's a flatten method baked in already:
[22] pry(main)> deep_nested_array = [1,2,[3,[4,[5,[6,7]]]]]
=> [1, 2, [3, [4, [5, [6, 7]]]]]
[23] pry(main)> deep_nested_array.flatten
=> [1, 2, 3, 4, 5, 6, 7]
chances are that there's a method in Ruby already for things that you might want to do -- look around! try a word as a method!

to find out what methods you can use on deep_nested_array, when in pry, do
EITHER cd deep_nested_array; ls
OR ls deep_nested_array

some methods you can do with arrays:
[32] pry(#<Array>):1> to_s
=> "[1, 2, 3, 4, 5, 6, 7]"
[33] pry(#<Array>):1> any? # is there anything in the array
=> true
[34] pry(#<Array>):1> [].any?
=> false
[35] pry(#<Array>):1> first # ask for the first value in the array
=> 1
[36] pry(#<Array>):1> first(2) # ask for the first 2 values in the array
=> [1, 2]
[37] pry(#<Array>):1> last
=> 7
[38] pry(#<Array>):1> last(2)
=> [6, 7]

adding stuff to the end of the array:
[42] pry(main)> arr = []
=> []
[43] pry(main)> arr.push 1
=> [1]
[44] pry(main)> arr.push 2
=> [1, 2]
[45] pry(main)> arr.push 3
=> [1, 2, 3]

pull/pop stuff out, starting from the end: it's last-in-first-out:
[46] pry(main)> arr.pop
=> 3
[47] pry(main)> arr
=> [1, 2]
[48] pry(main)> arr.pop(2) # you can also just pop multiple elements at the same time
=> [1, 2]
[49] pry(main)> arr
=> []

to add something to the beginning:
[52] pry(main)> arr.unshift 0
=> [0, 1, 2, 3, 4]
[53] pry(main)> arr.shift # as opposed to unshift
=> 0
[54] pry(main)> arr
=> [1, 2, 3, 4]

another way to do pop is to "<<":
[54] pry(main)> arr
=> [1, 2, 3, 4]
[55] pry(main)> arr << 5
=> [1, 2, 3, 4, 5]

and you can pop a specific element:
[56] pry(main)> arr.delete_at 2
=> 3

[57] pry(main)> greeting = "hello world"
=> "hello world"
[58] pry(main)> greeting.split(" ") # means split where the space is
=> ["hello", "world"]
OR do even more!
[59] pry(main)> greeting.split(" ").join("-->")
=> "hello-->world"

[63] pry(main)> arr = [1,2,3]
=> [1, 2, 3]
[64] pry(main)> arr.include? 2 # is there a 2?
=> true
[69] pry(main)> arr.index 2 # locate it
=> 1

you can join arrays:
[70] pry(main)> a1 = [1,2,3]
=> [1, 2, 3]
[71] pry(main)> a2 = [4,5,6]
=> [4, 5, 6]
[72] pry(main)> a1 + a2 
=> [1, 2, 3, 4, 5, 6]

you can find out where two arrays intersect:
[73] pry(main)> a1
=> [1, 2, 3]
[74] pry(main)> a2 = [2,3,99]
=> [2, 3, 99]
[75] pry(main)> a1 & a2 # note that it's just a single ampersand!
=> [2, 3]

sorting:
[76] pry(main)> a1 = [6, 2, 89, 1, 54, 2, 4]
=> [6, 2, 89, 1, 54, 2, 4]
[77] pry(main)> a1.sort
=> [1, 2, 2, 4, 6, 54, 89]
[78] pry(main)> a1.sort.reverse
=> [89, 54, 6, 4, 2, 2, 1]

just getting the unique numbers:
[79] pry(main)> a1 = [3, 3, 3, 4, 5]
=> [3, 3, 3, 4, 5]
[81] pry(main)> a1.uniq # haha
=> [3, 4, 5]

****************

3. RUBY: SYMBOLS AND HASHES

ON SYMBOLS

[82] pry(main)> sym = :hello_world
=> :hello_world
[83] pry(main)> str = "hello world"
=> "hello world"
[84] pry(main)> sym = :"hello      world"
=> :"hello      world"
[86] pry(main)> str.to_sym
=> :"hello world"
[88] pry(main)> sym.to_s
=> "hello      world"

object_id
-> memory address of that object
[94] pry(main)> str1.object_id
=> 70326956463480
[95] pry(main)> str2.object_id
=> 70326958297640
[96] pry(main)> str1.object_id == str2.object_id
=> false
[100] pry(main)> str1 == str2
=> true
i.e. even though the things behind the two strings (objects) are the same, they're still occupying two separate spaces
AS OPPOSED TO
[101] pry(main)> sym1.object_id == sym2.object_id
=> true
[102] pry(main)> sym1 == sym2
=> true
i.e. you don't waste memory when you use symbols
symbols are immutable, i.e. you can't just =+ " world" to it

ON HASHES

array
= ordered collection of values
e.g. companies = ["Apple", "Microsoft", "Google"]

hash
= associates values with keys, not indices
= "associative arrays" in other languages
e.g.
share_prices = { "Apple" => 454, "Microsoft" => 33, "Google" => 890 }
h = { k0 => v0, k1 => v1, … }

use h[key] to get values back:
share_prices["Apple"]
-> 454
share_prices["Pets.com]
-> nil # what's returned when you ask for a key that doesn't exist; same thing as in arrays
[104] pry(main)> arr[100]
=> nil

a hash's value can be an array if that's what you want:
[108] pry(main)> h = { "name" => "jon", "age" => "secret" }
=> {"name"=>"jon", "age"=>"secret"}
[109] pry(main)> h = { "name" => "jon", "age" => [12, 24, 35] }
=> {"name"=>"jon", "age"=>[12, 24, 35]}

keys are often symbols
string comparisons are slow because Ruby has to check one character at a time
symbol comparisons are faster because symbols that are the same have the same object ID
so use symbols!
[110] pry(main)> h = { :name => "jon", :age => "secret" }
=> {:name=>"jon", :age=>"secret"}

keys and values can be any valid Ruby object: array, integer, string, etc.

initialization
= create an empty 
e.g. 
h = Hash.new
-> {}
[111] pry(main)> h = Hash.new(99) # this gives it a new default value, not just nil
=> {}
[112] pry(main)> h[23]
=> 99

[113] pry(main)> h = {foo: 1, bar: 2, baz: 3} # alternative syntax since Ruby 1.9 and keys are always symbols if you use this syntax
=> {:foo=>1, :bar=>2, :baz=>3} # see? :foo denotes a symbol
and this new syntax is also similar to JavaScript syntax so it'll be helpful to use this

delete stuff:
[114] pry(main)> h.delete(:baz)
=> 3
[115] pry(main)> h
=> {:foo=>1, :bar=>2}

get stuff:
[116] pry(main)> h.keys
=> [:foo, :bar]
[117] pry(main)> h.values
=> [1, 2]

[118] pry(main)> h1 = { a: 1, b: 2 }
=> {:a=>1, :b=>2}
[119] pry(main)> h2 = { b: 3, c: 4 }
=> {:b=>3, :c=>4}
[120] pry(main)> h3 = h1.merge(h2)
=> {:a=>1, :b=>3, :c=>4} # note that the b is from h2
[121] pry(main)> h4 = h2.merge(h1)
=> {:b=>2, :c=>4, :a=>1} # note that the b is from h1

COMMON USE CASES

1. as lightweight objects
to store named information, e.g. all the Twitter = { name: Name, share_prices: 100 }; Facebook2 =  { name: Name, share_prices: 100 }
v.s. arrays to maintain lists of ordered stuff, e.g. stuff_by_coolness = [twitter, facebook, …]
benefits: fast, convenient (lots of useful methods), flexible (each record can have different attributes)

2. nested hashes
handy to group related data
h[key][nested_key]
Ruby on Rails, for instance, uses a nested Hash as kind of dictionary to put translations

****************

4. RUBY: ENUMERATORS AND BLOCKS

[125] pry(main)> (1..10).class
=> Range
[126] pry(main)> (1..10).to_a
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

to puts everything in an array (e.g. arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]), you can use a for-loop (even though there's a better way below):
[127] pry(main)> for n in arr
[127] pry(main)*   puts "--> #{n}"
[127] pry(main)* end  
--> 1
--> 2
--> 3
--> 4
--> 5
--> 6
--> 7
--> 8
--> 9
--> 10
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

instead of a for-loop, the more Ruby way is to use .each:
[130] pry(main)> arr.each do |value|
[130] pry(main)*   puts "--> #{value}"
[130] pry(main)* end  
--> 1
--> 2
--> 3
--> 4
--> 5
--> 6
--> 7
--> 8
--> 9
--> 10
=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
notes:
do…end is a block
|value| is a block argument

you can also put that in one line:
arr. each { |value| puts "--> #{value}" }
{} is a block

selecting stuff to push into an array with the .select method:
example:
[141] pry(main)> valid = (0..10).to_a.select { |value| value % 3 == 0 }
=> [0, 3, 6, 9]
see blocks.rb for the longer versions pre-refactoring

.collect and .map are the same method; both good to use whenever you need to iterate through an array AND get all the values back (i.e. no need to create a new empty array first; either method creates a new array of the values you indicate within the block)
[148] pry(main)> multiplied = (0..10).to_a.collect { |value| value * 3 }
=> [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30]
[149] pry(main)> plied = (0..10).to_a.map { |value| value * 3 }
=> [0, 3, 6, 9, 12, 15, 18, 21, 24, 27, 30]

NOW TO WORK ON HASHES INSTEAD OF ARRAYS:

[159] pry(main)> instructors.each do |value|
[159] pry(main)*   puts value.inspect  
[159] pry(main)* end  
[:instructor1, "Gerry"]
[:instructor2, "Jon"]
[:instructor3, "David"]
[:instructor4, "Julien"]
each returns the whole key-value set

do get just the value, pass 2 arguments (instead of just 1 like above) and then display what you want:
[162] pry(main)> instructors.each do |key, value|
[162] pry(main)*   puts "the key of #{value} is #{key}"  
[162] pry(main)* end  
the key of Gerry is instructor1
the key of Jon is instructor2
the key of David is instructor3
the key of Julien is instructor4

there's .each_with_index if you want to know where things are within the hash (also used for arrays):
[163] pry(main)> instructors.each_with_index do |value, index|
[163] pry(main)*   puts "the index of #{value} is #{index}"  
[163] pry(main)* end  
the index of [:instructor1, "Gerry"] is 0
the index of [:instructor2, "Jon"] is 1
the index of [:instructor3, "David"] is 2
the index of [:instructor4, "Julien"] is 3

.detect is the same as .find: see if the block is true and stop once it's true
[164] pry(main)> (1..10).to_a.detect { |value| value % 3 == 0 }
=> 3
[165] pry(main)> (1..10).to_a.find { |value| value % 3 == 0 }
=> 3

.find_all doesn't stop as soon as it's true but keeps going
[166] pry(main)> (1..10).to_a.find_all { |value| value % 3 == 0 }
=> [3, 6, 9]

****************

5. GIT

git add
git commit -m ""
git status (should say nothing to commit)
git checkout master
git merge w1d2-username