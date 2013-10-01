COMMENTS (BLOCKERS, SUCCESSES & QUESTIONS AFTER HOMEWORK)
=========================================================

Successes:
- Used to forget "end" a lot during pre-work; not much of an issue anymore
- Remembered most commands and syntax needed
- Could figured out where things went wrong and when might be a good idea to puts something just to check...

Blockers/Questions:
- Kept wondering how much validation should be done to user input as there seemed to be plenty of possible scenarios to think about,
e.g.
--- What if someone typed "a" for the first number and "b" for the second number? Tried that and found that Ruby returned "0 + 0 = 0", which was an interesting result to me as I originally thought it'd return an error instead of converting a non-number string to 0).
--- What if for the mortgage calculator's principal amount, the user typed in some currency symbols/abbreviations somewhere in there too?
etc. etc.
- Also, for the BMI Calculator's imperial-units option, I thought it was odd for someone to just know/input their height in inches and wondered if there's a way to take "5'2"" to then convert behind the scenes as 5x12+2 for the user. (It seemed silly to ask "5" feet and "2" inches in two separate prompts even though that's the easiest way to do it...)
- Got slowed down at times because of rusty math (and it's harder to read with the many parentheses)

********************

Tonight's Homework:

Buidling on the Calc-It app you've done in class today, add the three following features:

Mortgage Calculator:
Calculate the monthly payment when given the other variables as input.
you need principal, yearly interest rate and the number of payments 
http://www.wikihow.com/Calculate-Mortgage-Payments

BMI Calculator:
Calculate the BMI when given the height and weight - the user should be able to choose between the imperial and the metric system
http://en.wikipedia.org/wiki/Body_mass_index

Trip Calculator:
This feature asks the user for four inputs:
- Distance – how far will you drive?
- MPG – what is the fuel efficiency of the car?
- $PG – how much does gas cost per gallon?
- Speed – how fast will you drive?
The output is a string: “Your trip will take 3.5 hours and cost $255.33.”
For every 1 MPH over 60 MPH, reduce the the MPG by 2 MPG. (i.e. a car that normally gets 30 mpg would only get 28 mpg if its speed were 61 mph. Yes this gets silly at high speed where mpg goes to zero or gets negative.)

*******************

CLASS NOTES BELOW (W1D2)
=========================================================

0. HOMEWORK REVIEW (TRY GIT ON CODESCHOOL)

git branch -d BRANCH_NAME
-> delete a branch
when you merge branches, it just means you bring the snapshot of that one branch to merge with the other. it doesn't delete the branch you're merging from.

BEFORE YOU SWITCH TO A DIFFERENT BRANCH, COMMIT FIRST, BECAUSE OTHERWISE YOU BRING THE CHANGES TO THE OTHER BRANCH TOO.

[ file file file file file(modified) ]
|
|
v
git add: brings that modified file here; to eventually go on that snapshot/commit
|
|
v
git commit: is snapshot of that
|
|
v
git push: pushes that snapshot to github

*!* Git doesn't know how to recognize new empty folder! So if you create a new empty folder then do git status, it'll still say nothing to commit

git push origin master
= git push: command
= origin: remote
= master: branch

********************

1. GETTING ANSWERS

laziness, impatience, hubris

lazy programmers:
- write reusable software for common tasks
- write clear code, documentation and tutorials so they don't get bothered with questions
- answer in public forums so they only need to answer once

do:
- be lazy
- search online
- read documentations
- read source
- ask

// google: rtfm, stfw

google-fu
- use standard keywords
- include error messages in quotes
- include language
- include library if you know it
- include version numbers if necessary

documentation
Ruby
- ruby-doc.org
- use correct ruby version!
- ri and rdoc also an option, e.g. call ri upcase to read the doc about upcase
APIDock 
HTML/CSS/JS
- w3schools.com (simple)
- developer.mozilla.org (comprehensive)
- w3.org (detailed)
Shell
- self-documenting, can just do: man COMMAND_YOU'RE_INTERESTED_IN
- for things like Sublime, subl -h or subl --help

forums and groups
- ruby-forum.com
- elasticsearch google group

Q&A sites
- generalist: quora, yahoo
- specialist: StackExchange, incl. StackOverflow (programming), SuperUser (using software), Server Fault (deploy websites)

blogs, guides, tutorials
- http://guides.rubyonrails.org/
- video screencasts -- railscasts (http://railscasts.com/), PeepCode (https://peepcode.com/)
- personal and company blogs with ini-guides: thoughtbot, pivotal labs, intridea

********************

2. RUBY

REPL
read, evaluate, print, loop
e.g. Terminal is a REPL

irb
-> interactive Ruby
why use it? try snippets of Ruby to get feedback

exit
-> get out (of irb if that's where you were before)

you can call methods on objects

[stuff].class
-> show what type that is

greeting = "hello world"
irb(main):017:0> greeting.class
=> String
irb(main):018:0> "hello".class
=> String
irb(main):019:0> 99.999.class
=> Float
irb(main):020:0> 99.class
=> Fixnum
irb(main):021:0> 9999999999999.class
=> Fixnum
irb(main):022:0> 999999999999999999999999999999.class
=> Bignum
irb(main):023:0> true.class
=> TrueClass
irb(main):024:0> false.class
=> FalseClass
irb(main):025:0> nil.class
=> NilClass

methods for rounding up and down:
irb(main):031:0> 99.99.ceil
=> 100
irb(main):032:0> 99.99.floor
=> 99
irb(main):034:0> 99.99.round
=> 100

when argument is obvious, you can skip parentheses, e.g.
greeting.is_a? String WORKS THE SAME AS greeting.is_a?(String)
OTHERWISE you need things to be clear, e.g. differences like below:
irb(main):038:0> greeting.is_a? String
=> true
irb(main):041:0> greeting.is_a?(String).class
=> TrueClass
irb(main):042:0> greeting.is_a? String. class
=> false
irb(main):044:0> greeting.is_a?(String. class)
=> false

method with a question mark usually means the method returns a boolean value

String.class
=> Class
the class of string is a class

Ruby conventions:
- local variables: named_like_this (snake case)
- class: NamedLikeThis (camel case)
- constants: NAMED_LIKE_THIS (and Ruby does let you change the value of a constant, just with a warning telling you it's getting changed and which line the old value was at)

irb(main):048:0> 5 / 2
=> 2 # all integers in, so integer out
irb(main):049:0> 5.0 / 2
=> 2.5 # one float in, so a float out

irb(main):011:0> name = "jon"
=> "jon"
irb(main):012:0> msg = "#{name} loves ruby!"
=> "jon loves ruby!"

comparing stuff…
reminder of "spaceships":
irb(main):021:0> 0 <=> 3
=> -1
irb(main):022:0> 3 <=> 0
=> 1
irb(main):023:0> 3 <=> 3
=> 0

you don't remove variables; Ruby will figure out eventually that you have variables that aren't being used and "garbage collect" for memory

irb(main):024:0> str = "foobar"
=> "foobar"
irb(main):025:0> "foobar".class
=> String
irb(main):026:0> str = 'foobar'
=> "foobar"
irb(main):027:0> 'foobar'.class
=> String
i.e. to Ruby, '' and "" are the same in terms of inputting strings, and it uses "" itself in irb.

irb(main):029:0> str = 'Jon says "hi" to "WDI"'
=> "Jon says \"hi\" to \"WDI\""
where \ is the escape mark, essentially telling Ruby not to treat what comes after it the same way it normally would

\n, \t, etc. special characters only work within ""
single quotes get you:
irb(main):034:0> greeting = '\thello\nworld'
=> "\\thello\\nworld"
irb(main):035:0> puts greeting
\thello\nworld

string interpolation also only works within "":
irb(main):036:0> name
=> "jon"
irb(main):037:0> msg = "#{name} says hi!"
=> "jon says hi!"
irb(main):038:0> msg = '#{name} says hi!'
=> "\#{name} says hi!"

when you create a string with "", Ruby actually does more stuff behind the scenes to interpret it. '' is faster for Ruby because it just treats things literally.

inspect
-> 
irb(main):040:0> "my string".inspect
=> "\"my string\""
irb(main):041:0> "my string".to_s
=> "my string"

p my_value
IS THE SAME AS my_value.inspect

print "my string"
-> ...one line

.chomp removes new line after:
irb(main):044:0> user = gets
jon
=> "jon\n"
irb(main):045:0> user = gets.chomp
jon
=> "jon"

.strip would get rid of blank/white space:
irb(main):047:0 >  " test \n ".strip
=> "test"

method with an exclamation means DANGER, e.g. str.chomp! changes the original str, while str.chomp keeps the original str

`whoami`
= back ticks (``) get you back to shell commands

puts `clear`
= normal clear in shell commands = cmd+K in shell commands

don't use eval, esp. if it accepts user input, because it can take anything and do evil stuff

if…end
if…else…end

unless… (can be followed with else too but not recommended because it just reads weird)

while…end (careful not to be stuck in an infinite loop; need to update count each time)

while loops can be structured differently:
irb(main):040:0> begin
irb(main):041:1* puts x
irb(main):042:1> x += 1
irb(main):043:1> end while x < 10
1
2
3
4
5
6
7
8
9
=> nil
that way x will print at least once because the "begin…puts x" comes before Ruby reads any conditions

until…end

for….end

0..5
represents a range of numbers
irb(main):054:0> (0..5).class
=> Range
you can call methods on that too, e.g.
irb(main):055:0> (0..5).include? 3
=> true

loop do…break if… end

case SOMEVARIABLE…when VALUE…(else…)end
if you want the conditions-do on one line, you can also do it by "then" (like how you'd do it with if-then statements)
the conditions are evaluated in the order it's written, so for:
irb(main):069:0> case x
irb(main):070:1> when 0..5 then puts "small"
irb(main):071:1> when 5..10 then puts "big"
irb(main):072:1> else puts "dunno"
irb(main):073:1> end
if x is 5, it'll puts "small"

all things in Ruby are true except for false and nil
for example, 0 is false in JavaScript and many other languages, but not in Ruby:
irb(main):075:0> if 0 then puts "foo" end
foo
=> nil
irb(main):076:0> if nil then puts "foo" end
=> nil # because nil is kind of like false here; so the statement's "if" isn't true and the result is nil because there's no "puts 'foo'" to be done and no else-to-do either
irb(main):077:0> if false then puts "foo" end
=> nil

||
= or

&&
= and

!true
=> false

!nil
=> true

irb(main):081:0> puts "hello"
hello
=> nil # put-string something, then Ruby gives the return value of nil because we didn't give it a return value
irb(main):082:0> p "hello"
"hello"
=> "hello" # our command meant to print AND return value of "hello" so Ruby doesn't have to return nil

ruby gems are usually hosted on github these days
e.g. https://github.com/sickill/rainbow

require "GEM"
-> tell Ruby to load some gem we want to use now

irb(main):007:0> def say_hello
irb(main):008:1> puts "say_hello"
irb(main):009:1> end
=> nil # nil is the return value by default 
irb(main):010:0> say_hello
say_hello
=> nil

DRY = don't repeat yourself
WET = write everything twice
so use methods!

.capitalize 
=> cap first letter only

.upcase
=> cap all

you can call a function within another function:
irb(main):034:0> def capitalize_name name
irb(main):035:1> return name.capitalize
irb(main):036:1> end
=> nil
irb(main):037:0> capitalize_name "mel"
=> "Mel"
irb(main):038:0> def say_hello_to name
irb(main):039:1> puts "Hello to #{capitalize_name(name)}"
irb(main):040:1> end
=> nil
irb(main):041:0> say_hello_to "mel"
Hello to Mel
=> nil

you can't begin a function name with a number, i.e. no def 2_plus_2
and on that note, if you're writing a function that's meant to return a boolean, then name it with the convention of ending it with a question mark, e.g. def is_true?

the last line in your function is always the return value by default in Ruby

pseudo-code (think through what you're doing):
example -- for def say_hello_to name; puts "Hello #{name}"; end
- write a function 
- the function should take a name then return the name along with "Hello"

CLASSWORK:
You've to create a calc program, this program will run in the command line , and prompt the user to choose the operation to execute (add, subtract, multiply, divide), and then ask for the first number , then the second one.
- show an invite to the user
- prompt the user what operation is needed
- store the value typed in by the user
- prompt the user for the first number
- store the first number
- prompt the user for the second number
- store the second number 
- pass the three values to a function
- display the result