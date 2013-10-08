COMMENTS & QUESTIONS AFTER HOMEWORK
===================================



Tonight's Homework
********************
## Write SQL statements for the included DB that:
    1. Selects the names of all products that are not on sale.
    2. Selects the names of all products that cost less than £20.
    3. Selects the name and price of the most expensive product.
    4. Selects the name and price of the second most expensive product.
    5. Selects the name and price of the least expensive product.
    6. Selects the names and prices of all products, ordered by price in descending order.
    7. Selects the average price of all products.
    8. Selects the sum of the price of all products.
    9. Selects the sum of the price of all products whose prices is less than £20.
    10. Selects the id of the user with your name.
    11. Selects the names of all users whose names start with the letter "A".
    12. Selects the number of users whose first names are "Jonathan".
    13. Selects the number of users who want a "Teddy Bear".
    14. Selects the count of items on the wishlish of the user with your name.
    15. Selects the count and name of all products on the wishlist, ordered by count in descending order.
    16. Selects the count and name of all products that are not on sale on the wishlist, ordered by count in descending order.
    17. Inserts a user with the name "Jonathan Postel" into the users table. Ensure the created_at column is set to the current time.
    18. Selects the id of the user with the name "Jonathan Postel"?  Ensure the created_at column is set to the current time.
    19. Inserts a wishlist entry for the user with the name "Jonathan Postel" for the product "The Ruby Programming Language".
    20. Updates the name of the "Jonathan Postel" user to be "Jon Postel".
    21. Deletes the user with the name "Jon Postel".
    22. Deletes the wishlist item for the user you just deleted.

Products
id
created_at
name
on_sale (Boolean)
Price

Users
id
created_at
name

wishlists
id
created_at
user_id
product_id


CLASS NOTES
===================================

0. HOMEWORK REVIEW
********************

@portfolios.values -> return an array of the values of the portfolio instances

@portfoliosvalues.map do |position|
  portfolio.position
end
(can be refactored as @portfolios.values.map(&:position)


1. FILE I/O
********************

file opening modes
r: read-only mode (pointer/cursor at the beginning)
r+: read write mode (pointer/cursor at the beginning, i.e. you add stuff before the existing content)
w: write mode (overwrite the file)
w+: read write mode (overwrite the file) 
a write only (pointer at the end)
a+: read write mode (pointer at the end)

file = File.new("./database.txt", "a+") # Ruby will create a file named that if it doesn't exist

if you don't close a file, the program will run and end and the file will still be open
close with: file.close

file = File.new("./database.txt", "a+") # Ruby will create a file named that if it doesn't exist yet
# print "Add info for a new person (name, age, sex) "
# file.puts gets.chomp
# file.close # you must do this!

READ
file = File.new("./database.txt", "r")
file.each do |line|
  puts line.chomp.split(",")
end
file.close # yes, still need to do that

cdv is a Ruby class
write array in


2. EXCEPTIONS (RUBY)
********************

unexpected errors
deal with them with exception handling

examples seen:
NoMethodError
ArgumentError
NameError
SyntaxError
ZeroDivisionError
e.g. [1] pry(main)> 99.upcase
NoMethodError: undefined method `upcase' for 99:Fixnum
from (pry):1:in `__pry__'
[2] pry(main)> 100 / 0
ZeroDivisionError: divided by 0
from (pry):2:in `/'

exceptions don't crash pry because it's a REPL
but they will crash a program run from a file, e.g. example_1.rb

crashing means that whatever code follows will never be executed

➜  examples git:(w2d1-maloneyl) ✗ ruby example_1.rb
about to divide 100 by 0
example_1.rb:8:in `/': divided by 0 (ZeroDivisionError)
  from example_1.rb:8:in `silly_calc'
  from example_1.rb:3:in `run_example'
  from example_1.rb:11:in `<main>'
the "from…." bits are backtrace (lines where we got to the error)
rb:8 is the last line where things went wrong
rb:3 was what got us there ^
rb:11 was what got ut there ^

exemptions are classes that inherit from Exception!
you can initialize your own:
my_error = ZeroDivisionError.new "DIVISION BY ZERO IS NAUGHTY!!!!"
[4] pry(main)> my_error.class.ancestors
=> [ZeroDivisionError,
 StandardError,
 Exception,
 Object,
 PP::ObjectMixin,
 Kernel,
 BasicObject]
you almost always inherit from StandardError instead of Exception directly (more on this later)

trigger the error with raise:
[5] pry(main)> raise my_error
ZeroDivisionError: DIVISION BY ZERO IS NAUGHTY!!!!
from (pry):5:in `__pry__'

exceptions don't have to crash your program -- if you do rescue
---------
begin
  puts "the result of 100 divided by 0 is #{100/0}"
rescue
  puts "whoopsie"
end
----------
Ruby jumps into the rescue block instead of getting stuck in the 100/0
then run the rest of the code
if the rescue block is empty then it'll just carry on

you can trap the exception and interrogate it if it's useful to you
rescue => e
-> pass the error object

------------
     3: puts "about to do something stupid..."
     4: 
     5: begin
     6:   puts "the result of 100 divided by 0 is #{100/0}"
     7: rescue => e # pass the error object
 =>  8:   binding.pry
     9:   puts "whoopsie: #{e}"
    10:   puts "backtrace was:"
    11:   puts e.backtrace.join("\n")
    12: end
    13: 

[1] pry(main)> e
=> #<ZeroDivisionError: divided by 0>
[2] pry(main)> e.class
=> ZeroDivisionError
[3] pry(main)> ls e
Exception#methods: 
  ==            __bb_context  __bb_line  exception  message      set_backtrace
  __bb_binding  __bb_file     backtrace  inspect    respond_to?  to_s         
[4] pry(main)> e.message
=> "divided by 0"
[5] pry(main)> e.backtrace
=> ["example_3.rb:6:in `/'", "example_3.rb:6:in `<main>'"]
[6] pry(main)> exit
whoopsie: divided by 0
backtrace was:
example_3.rb:6:in `/'
example_3.rb:6:in `<main>'
AWESOME - I didn't crash!
---------------

else
-> lets us run code only if no error occurs (not really useful)
ensure
-> run no matter what happens (very useful)
e.g.
➜  examples git:(w2d1-maloneyl) ✗ ruby example_4.rb
what shall I divide 100 by? 10
the result of 100 divided by 10 is 10
this 'else' clause is called ONLY if no exception is raised
this 'ensure' clause is called no matter what happens
AWESOME - I didn't crash!
➜  examples git:(w2d1-maloneyl) ✗ ruby example_4.rb
what shall I divide 100 by? 0
whoopsie: divided by 0
this 'ensure' clause is called no matter what happens
AWESOME - I didn't crash!

example_5.rb shows how you use the ensure clause with file.close so that even if you run into errors while modifying the file, the file still gets closed at the end

selective rescue
just write the rescue clause for what you want to catch! e.g.
---------
begin
  puts "running your code gives: #{eval code}"
rescue ZeroDivisionError
  puts "dividing by zero is pretty dumb!"
rescue NameError, NoMethodError # comma-separated lists
  puts "mentioning unknown variables or methods is a no-no!"
end
--------
then it'll only catch ZeroDivisionError, NameError and NoMethodError
so if you have a SyntaxError, it won't be rescued and it will just crash

we might have our own rules/situations for our code/program that we don't want our users to do, even if they are completely valid in Ruby. usually we want to tell other debs what went wrong with our code
so we want new classes of exception, esp. if we build modules
e.g. file_parsing (a realistic example!) > lib > simple_csv.rb
read line 115

reminder: when you define classes/modules within another module, the namespace is OriginalModule::TheOtherModule

if you try to open a file that doesn't exit, Ruby gives you the standard ENOENT file error, named borrowed from Unix:
irb(main):001:0> f = File.open "foobar.txt"
Errno::ENOENT: No such file or directory - foobar.txt
  from (irb):1:in `initialize'
  from (irb):1:in `open'
  from (irb):1
  from /Users/Maloney/.rbenv/versions/2.0.0-p247/bin/irb:12:in `<main>'
so you might want to create an error with a better name…e.g. simple_csv.rb in line 52

file.gets
-> reads one line at a time

look into what array slice is

.all
-> step through all the elements in the array


3. DATABASES (POSTGRE)
********************

SQL = structured query language

there are SQL databases and non-SQL databases

PGSQL= Postgre SQL
what we'll be using

MySQL: php, WordPress
bought by Oracle, the largest paid provider 

psql
help
-> self-explanatory
\?
-> all commands shown

Maloney=# create database my_first_database
Maloney-# ;
CREATE DATABASE # these are SQL keywords; conventions are in caps
^-- needs to end a command with semi-colon! otherwise it'll just keep waiting...

\l
-> list [your databases]

to remove the database, the keyword is drop
Maloney=# drop database my_first_database
Maloney-# ;
DROP DATABASE # these are SQL keywords

\c
-> connect to… (a database)
Maloney=# \c address_book
You are now connected to database "address_book" as user "Maloney".

address_book=# \d
-> list all the tables inside the database
No relations found.

creating tables: columns and rows
each heading might be associated with a different data type, e.g. Name: string, Phone: integer, Birthday: date

data types:
varchar (255 characters max.; but if you know something can't be that long, specify the length and save memory)
text (no length limit; i.e. just consumes more memory)
int
int2 (alias for smallest; signed two-byte integer)
int4
int8
int16
bigint
char (if you use char(10) for a single-char field like gender, psql will convert it as 1 char of the real value + 9 spaces)
serial2
serial4
serial8 (alias for big serial; autoincrementing eight-byte integer)
serial16
date

address_book=# CREATE TABLE people(name varchar(255), age int2, gender char(1));
-> create a table (SQL keywords in caps, mind you) named people, with a column called name that's of varchar data type with a maximum length of 255 characters, a column called age that's of int2 data type, and a column called gender that's of char data type with a length of 1

now if you do \d you should see that table listed

CRUD
= create, read, update, delete

note: never use a SQL keyword in your naming...

SELECT * FROM people;
-> select all fields from the table named people; this is the read-data 

these will result in new rows of just one column cell field each time:
INSERT INTO people (name) VALUES ('Gerry');
INSERT INTO people (age) VALUES (21);

this will result in the whole row populated properly:
INSERT INTO people (name, age, gender) VALUES ('Jon', 41, 'M');

UPDATE people SET age=20 WHERE name='Gerry'; # where is the condition; otherwise all will be updated!
UPDATE people SET name='Gerry', age=20 WHERE name='Gerry';

DELETE FROM people WHERE age=21; # where is the condition; otherwise all will be updated!

*******
address_book=# CREATE TABLE weather(
address_book(# id serial8 primary key,
address_book(# city varchar(255) unique not null,
address_book(# low int default 0,
address_book(# high int check (high > low),
address_book(# high_recorded_on date,
address_book(# low_recorded_on date);
CREATE TABLE
********

serial8
= 
primary key
= we index with this; auto-generated; you'll need this most of the time! otherwise you won't be able to go back and change duplicate data (e.g. if you have multiple Gerry's in address_book, you can't change only one of those rows)

unique
= like serial8 but for varchar

not null
= cannot be empty; will prompt an error

default 0
= setting a default value of 0 so even if you don't enter it when you do an insertion, it'll be inserted automatically

check (CONDITION)
= give psql something to check and raise an error if false
e.g.
low int default 0,
high int check (high > low)

retrieve data from tables by their foreign keys
e.g. Jack has a student ID of 12, is enrolled in WDI which has a course ID of 8, and the WDI in turn has a schedule ID of 101
Students -- ID: 12, Name: Jack, Course_ID: 8
Courses -- ID: 8, Name: WDI, Schedule_ID: 101
Schedules -- ID: 101, Name: OO

Basically, you have 3 main tables, and then 2 mini-ones where their IDs intersect
Students -- ID, Name  Courses -- ID, Name     Schedules -- ID, Name
  * Student_ID, Course_ID *   * Course_ID, Schedule_ID *

sql git:(w2d1-maloneyl) ✗ psql -d campus -f campus.sql <--- this means….database and file, I guess?
➜  sql git:(w2d1-maloneyl) ✗ psql
psql (9.3.0)
Type "help" for help.

Maloney=# \c campus
You are now connected to database "campus" as user "Maloney".
campus=# \d
               List of relations
 Schema |       Name       |   Type   |  Owner  
--------+------------------+----------+---------
 public | courses          | table    | Maloney
 public | courses_id_seq   | sequence | Maloney
 public | schedules        | table    | Maloney
 public | schedules_id_seq | sequence | Maloney
 public | students         | table    | Maloney
 public | students_id_seq  | sequence | Maloney
(6 rows)

re: campus.sql
campus=# SELECT id FROM courses WHERE name='Biology';
 id 
----
  1
(1 row)
campus=# SELECT student_id FROM schedules WHERE course_id=1;
 student_id 
------------
          2
(1 row)
campus=# SELECT * FROM students WHERE id IN (2);
 id | first | last  |    dob     
----+-------+-------+------------
  2 | sally | jones | 1950-01-01
(1 row)

IN is kind of like an array; you provide a range

you can combine the two above with:
campus=# SELECT * FROM students WHERE id IN (SELECT student_id FROM schedules WHERE course_id = 1);
 id | first | last  |    dob     
----+-------+-------+------------
  2 | sally | jones | 1950-01-01
(1 row)

this is called joining tables

in psql, this is create database Facebook, but in Shell, psql has this unix command:
➜  facebook-sql git:(w2d1-maloneyl) ✗ createdb facebook    # postgre unix command
which you then open with
➜  facebook-sql git:(w2d1-maloneyl) ✗ psql -d facebook -f facebook.sql
then you go into psql
➜  facebook-sql git:(w2d1-maloneyl) ✗ psql
then you connect to the database
Maloney=# \c facebook

re: facebook.sql
to filter by last names alphabetically:
  SELECT * FROM people ORDER BY last;
to filter by ID in ascending order:
  SELECT * FROM people ORDER BY id ASC;
to filter by ID in descending order:
  SELECT * FROM people ORDER BY id DESC;
to filter by date of birth in ascending order:
  SELECT * FROM people ORDER BY dob ASC;
to update anything, SET that something WHERE some row reference:
  UPDATE people SET dob='1/1/1987' WHERE first='Gerry';
to get the sum of some column (e.g. friends) and return that to a fake column:
  SELECT SUM(friends) AS total_friends FROM people;
to count the number of entries (rows):
  SELECT COUNT(*) FROM people;
to count the number of entries (rows) with some condition:
  SELECT COUNT(*) FROM people WHERE dob > '1 Jan 1970'
to filter by first names starting with the letter 'J':
  SELECT *  FROM people WHERE first LIKE 'J%'; # this is v. memory-consuming and not really used IRL
to filter by first names starting with the letters 'Ji':
  SELECT *  FROM people WHERE first LIKE 'Ji%';
to filter by first names containing with the letter 'i':
  SELECT *  FROM people WHERE first LIKE '%i%';

snake case for SQL, apart from keywords which are all in caps

bonsai and textacular are better for full-text search

using it in ruby:
*******************************************
require 'pg'
require 'pry'

begin
  db = PG.connect(dbname: 'facebook', host: 'localhost')
  
  # with PG connected above, you can call. exec to run psql queries like SELECT...
  # db.exec("SELECT * FROM people") do |result| # result refers to that table we see in shell
  #   result.each do |row|
  #     p row
  #   end
  # end

  print "Full name: "
  name = gets.chomp.split # so that first and last names are split into an array
  print "Date of birth: "
  dob = gets.chomp
  print "City: "
  city = gets.chomp

  sql = "INSERT INTO people (first, last, dob, city) VALUES ('#{name[0]}', '#{name[1]}', '#{dob}', '#{city}')"
  db.exec(sql)

  db.exec("SELECT * FROM people") do |result|
     result.each do |row|
       p row
     end
  end

ensure
  db.close # again, v. important to close the db file

end # this is re: the begin…ensure…end
*******************************************
