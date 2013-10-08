COMMENTS AND QUESTIONS AFTER HOMEWORK
=====================================

- Not surprisingly, HTML and CSS are easier to understand, possibly because they don't seem as abstract and also because I've had more experience with them before
- That said, it's not that I just know how the different position options work, what line-height means, etc. It's just that it's easier to try things out and see what changes and make updates that way.


CLASS NOTES
===========

0. HOMEWORK REVIEW
*******************

3. Selects the name and price of the most expensive product.
``````
SELECT name, price FROM products ORDER BY price DESC LIMIT 1;
``````
or (from homework review):
``````
SELECT name MAX(price) AS max_price FROM products;
``````
NOTE that your labeling of the "AS" will become the column heading in your result table


4. Selects the name and price of the second most expensive product.
``````
SELECT name, price FROM products ORDER BY price DESC OFFSET 1 LIMIT 1;
``````

5. Selects the name and price of the least expensive product.
``````
SELECT name, price FROM products ORDER BY price ASC LIMIT 1;
``````
or (from homework review):
``````
SELECT name MIN(price) AS min_price FROM products;
``````

7. Selects the average price of all products.
``````
SELECT AVG(price) AS average_price FROM products;
``````

writing comments in sql files, do "--". that's the equivalent of # in Ruby.


13. Selects the number of users who want a "Teddy Bear".
``````
SELECT COUNT(users) FROM wishlists WHERE product_id IN (SELECT id FROM products WHERE name = 'Teddy Bear');
``````
use IN instead of '=' because the latter will only work if there's one result:


15. Selects the count and name of all products on the wishlist, ordered by count in descending order.
``````
SELECT name, COUNT(id) AS products_count FROM products WHERE product_id IN
(SELECT product_id FROM wishlists) GROUP BY name ORDER BY products_count DESC;
``````
subrequests work, but you can join tables too (which we'll learn later)


16. Selects the count and name of all products that are not on sale on the wishlist, ordered by count in descending order.
``````
SELECT name, COUNT(id) AS products_count FROM products WHERE on_sale = 'f' AND product_id IN (SELECT product_id FROM wishlists) GROUP BY name ORDER BY products_count DESC;
``````

22. Deletes the wishlist item for the user you just deleted. ****
``````
DELETE FROM wishlist WHERE user_id = (SELECT id FROM users WHERE name = 'Jon Postel');
``````
correct answer from homework review:
``````
DELETE FROM wishlists WHERE user_id NOT IN (SELECT id FROM users);
``````

1. RUBY: ADVANCED BLOCKS
*************************

RUBY: ADVANCED BLOCKS

you can write methods that take blocks as an argument
blocks of code can be stored in variables

blocks are just anonymous methods, e.g. how enumerable methods use them

[1] pry(main)> numbers = [100, 42, 3.141]
=> [100, 42, 3.141]
[2] pry(main)> sum = numbers.reduce(0) { |total, num| total += num }
=> 145.141
in that .reduce method, total at first is the initial value you set, which is 0 in this case
[3] pry(main)> product = numbers.reduce(1) { |prod, num| prod *= num }
=> 13192.2

we can pass a block as an argument, but then the regular argument must be in parentheses in this case

yield to a block

block_given? is a method that all methods get for free
********************
[4] pry(main)> def say_my_name(name)
[4] pry(main)*   puts "your name is #{name}"
[4] pry(main)*   yield("foo", 99) if block_given?
[4] pry(main)* end  
=> nil
[5] pry(main)> say_my_name("Jon") { |x, y| puts "x is #{x} and y is #{y}" }
your name is Jon
x is foo and y is 99
=> nil
[6] pry(main)> say_my_name("Jon") # no block given
your name is Jon
=> nil
********************
if you don't specify the "if block_given?" then Ruby will return an error if you don't pass a block when you call say_my_name because yield doesn't have a block to use

you can also pass a block explicitly and call it:
[4] pry(main)> def say_my_name(name, &block)
[4] pry(main)*   puts "your name is #{name}"
[4] pry(main)*   block.call("foo", 99) if block # you still need this "if block"
[4] pry(main)* end  

INVALID RUBY SYNTAX:
  my_block =  { |x, y| puts "x is #{x} and y is #{y}" }
VALID RUBY SYNTAX:
  my_proc = Proc.new { |x, y| puts "x is #{x} and y is #{y}" }
then you can call it:
  my_proc.call 2, 3

you can have a method build a custom Proc (and dynamically create new blocks of code as you go), e.g.
[7] pry(main)> def make_multiplier(scalar)
[7] pry(main)*   Proc.new { |x| x * scalar }
[7] pry(main)* end  
=> nil
[8] pry(main)> times_2 = make_multiplier(2)
=> #<Proc:0x007fb4d411cfc0@(pry):11>
[9] pry(main)> times_3 = make_multiplier(3)
=> #<Proc:0x007fb4d40cc3b8@(pry):11>
[10] pry(main)> (1..10).map(&times_2)
=> [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]
[11] pry(main)> (1..10).map(&times_3)
=> [3, 6, 9, 12, 15, 18, 21, 24, 27, 30]

less typing is good!
&:some_method: tells Ruby to make a new Proc that calls some_method on its arguments, e.g.
*****
numbers = [ 100, 42, 3.141 ]
strings = numbers.map { |num| num.to_s }
*******
can be turned into:
numbers = [ 100, 42, 3.141 ]
strings = numbers.map(&:to_s)

sum = numbers.reduce(&:+)
product = numbers.reduce(&:*)

lambda is similar to proc and is another way to assign a block to a variable
******
my_lambda =  { |x, y| puts "x is #{x} and y is #{y}" }
my_lambda.call 2, 3
******
lambdas are strict about the number of arguments they get, while procs are not (if you don't give an argument to a proc, the proc just thinks it's nil; or if you pass too many arguments to a proc, it just ignores the extras):
e.g.
my_lambda.call 2 => ArgumentError: wrong number of arguments (1 for 2)
my_proc.call 2 => x is 2 and y is

alternative syntax for Proc since Ruby 1.9:
create with:
  my_proc = ->(x,y){puts "x is #{x} and y is #{y}" }
call with:
  my_proc.(2,3)

even blocks of code are objects in Ruby!
pass blocks as arguments to call them or yield to them

2. HTML & CSS
**************

HTML
HyperText Markup Language

markup languages = to write and format document, not giving instructions to a computer like programming languages do
e.g. markdown (e.g. what we've been doing with Mou) and HTML

in Sublime, can just type a valid HTML structure then tab for the open-and-close tags, e.g. type p and tab for <p></p>, type html and tab for lots of stuff

p: paragraph
h1-h6: 6 header formats
ol: ordered list
ul: unordered list
li: list item

self-closing tags: e.g. <img />, <meta>

by default:
span is an in-line element, i.e. only takes the space it needs
div is a block element, i.e. takes the whole width by default
span and div are useful to define the layout on a webpage, e.g. div for the header and footer, span for navigation, etc. don't ever use tables for this!

in Chrome, cmd+alt+i opens up show elements (developer tools)
you can inspect hover over each element there and see how much space it takes (i.e whether it's in-line or block)

table
-> thead
  -> tr
    ->th
-> tbody
  -> tr 
    -> td

<strong></strong> vs. <b></b>
<em></em> vs. <i></i>
semantic web (web 3.0)
they are different in speech readers (like it'll actually sound stronger with <strong></strong>) and search engines even if we see the same thing in a browser
for example, use <i></i> for foreign words and <em></em> for actual emphasis

in Chrome, cmd+alt+u opens source 

when's in <head></head>: title, meta,

CSS
cascading style sheet

text format (font, size, shadow)
color
position
size

HTML is just content

syntax:
select {
  property_1: value_2;
  property_2: value_2;
}

border: 1px solid black;
is the shortcut of all these:
  border-width: 1 px;
  border-style: solid;
  border-color: black;

to comment in CSS, /* comment */

id: define unique elements in an html file
e.g. <div id="div_1"></div>, then in css you'll refer to it as div#div_1

the more specific you are about an element, the higher priority its declaration
that is, even if a more-general version appears further down the CSS, the specific version will still win

div#div_2, div#div_3 { /* can declare two things at a time comma-separated */
  background-color: red;
}

class: doesn't have to be unique
e.g.
  div.bg_red {
      background-color: red;
  }
DO THIS! not with ID!

id > class > element

you can have multiple classes, separated by just a space:
<div id="div_1" class="text-right bg_red comic-sans">DIV 1</div>

NOTE THE DIFFERENCES BELOW
-------------------------------
.hidden {
  visibility: hidden; /* the space that the element occupied will still be there */
}

.gone {
  display: none;  /* the space that the element occupied won't even be there */
}
-------------------------------

you can test and live-edit things in cmd+alt+i (Chrome's developer tool) as a preview
but you can't save it

don't do in-line CSS!
and don't do <style></style> in the html doc's head
keep CSS file separate so yon can use it for more html files and change just one file
if there are conflicts, the in-line one will take precedent, then the html-head one, then the linked one

element/content - padding - border - margin
Chrome's developer tool has a nice box that shows that

margin - element vs. another element
if you don't do margin-top, margin-right, margin-bottom, margin-left, you can do just margin and have it apply to that direction (it goes clockwise from top)

if you set div_2 to be 50% width (of div_0), the div_2 element's width will be 50% of the div_0 element's width, but div_2 can still have lots of margin and padding to make it not look 50%

and if you define a padding for div, then you nest another div inside and they all share the same div style, then the nested div will have double-padding

POSITIONING
1. static positioning: default -- just block or inline, plus any margin, padding, border
2. relative positioning: relative to itself at static stage
3. absolute positioning: based on position of closest parent that is absolute or relative
(so for that first div, parent means the browser window; for the nested div, parent means that first/outer div)
4. fixed positioning: based on window/viewpoint and stay there even if you scroll
5. float positioning: syntax a little different -- float: right (or left) -- and it could mean that the div originally underneath will float up, so have that other div "clear: both"

if you see a css style in just one line, that's to save space and load faster. product sites with big CSS will do that.

DOM 
dominant object model
tree structure like:
html
-> body
--> p
----> plain text
