QUESTIONS AND COMMENTS AFTER HOMEWORK
=============

Not a lot of problems, just have to get used to the new syntax and how JS does things, I suppose!
Haven't got to the extra bits of the homework...


CLASS NOTES
=============

1. JAVASCRIPT: INTRO
----------------------------------

YARV
yet another ruby virtual machine

V8
javascript interpreter for chrome
javascript is another interpreted language, and chrome is an interpreter
chrome's dev tools: v. good for javascript

DOM
document object model

a document has functions that you can call,
e.g.
  document.write("wdi");
similar to CSS, if it's just one line, you can omit the semi-colon

javascript has strict syntax, is case-sensitive
// to comment on one line
/* comment */ to comment on multiple lines

to insert javascript in the html file, use the tags in the head (because you want the javascript loaded before the body): <script type="text/javascript"></script>
in html5, just <script></script> would suffice
for html3 and html4 and IE, do <script type="text/javascript" language="javascript"></script>

let's say we do that, and then get a <div id="container"></div> in the body:
if we then go to the console (chrome's dev tools), we can do:
document.getElementById("container")
  . <div id=​"container">​</div>​

but if we're to put that in our javascript in the head, the div 'container' doesn't' exist yet
sometimes you deal with that by putting your script at the bottom (past the container)
let's try that, with this:
<script type="text/javascript" language="javascript">
      console.log(document.getElementById("container"))
</script>
now when we reload the page, we'll see more cool stuff in the console (which only exists in chrome and firefox)
we see div#container returned, plus "index-test.html:10" indicating where we called it
and if we move those 3 lines of code in the head, what's returned is "null"

but there's another way, of course…
window
= browser
also comes with lots of functions, e.g. window.onload, which gets the browser to evaluate the javascript code only after everything else is loaded

now we can try this in the head:
    <script type="text/javascript" language="javascript">
      window.onload = function() {
        console.log(document.getElementById("container"))
      }
    </script>
cool, we're returned "div#container" on line 6

now just for comparison, let's add:
    <script type="text/javascript" language="javascript">
      window.onload = function() {
        console.log(document.getElementById("container"))
      }
      console.log(document.getElementById("container"))
    </script>
what's returned:
   null: index-test.html:8
   div#container: index-test:6
that's because the onload function waits for the whole page to load first

and again, similar to CSS, you can save the javascript in a separate file and call it with a src attribute:
<script src="./script.js"></script>

defining a variable in javascript:
  a_key = "a_value";
or with the 'var':
  var another_key = "another_value";
we'll learn about the difference….
and we can print the variable in that chrome dev console

// primitive types:
a_variable_with_a_number = 2000;
a_variable_with_a_string = "a string";
a_variable_with_a_boolean = true;
> a_variable_with_a_boolean
false

create a new object with new Something:
> new String()
String {}
> new String("wdi")
String {0: "w", 1: "d", 2: "i"}
> "this is also a string object"
"this is also a string object"

you can call property on a string object:
> "this is also a string object".length
28
> "this is also a string object".indexOf()
-1
> "this is also a string object".indexOf("s") # returns the first appearance of that char
3
> "this is also a string object".lastIndexOf("s")
15
> "this is also a string object".charAt(8)
"a"
> "this is also a string object"[8] # because the string is an array (see above "wdi" example)
"a"
> "this is also a string object".substr(1,4) # similar to ruby's range 1..4; inclusive range
"his "
> "this is also a string object".substring(1,4) # similar to ruby's range 1…4; exclusive
"his"
> "this is also a string object".split("s")
["thi", " i", " al", "o a ", "tring object"]
> "this is also a string object".toLowerCase()
"this is also a string object"
> "this is also a string object".toUpperCase()
"THIS IS ALSO A STRING OBJECT"

if you save a string object in a variable, chrome's dev tool will now know to give you the function list for string objects
> my_variable = "gerry mathe"
"gerry mathe"
> my_variable.[THAT LIST SHOWS UP!]

we'll do something with date objects:
> date = new Date()
Mon Nov 04 2013 10:12:33 GMT+0000 (GMT) # returns current time
> date = new Date(1000)
Thu Jan 01 1970 00:00:01 GMT+0000 (GMT) # returns unix time plus 1000 milliseconds
> new Date() - new Date(0) # get unix time
1383560285257
> date = new Date(1383560135000)
Mon Nov 04 2013 10:15:35 GMT+0000 (GMT)
> date = new Date("November 4, 2013") # can pass a string in too
Mon Nov 04 2013 00:00:00 GMT+0000 (GMT)
> date.getTime()
1383523200000
> date.getDay() # get days of the week, where 1 = Mon, 0 = Sun, etc.
1
> date.setYear("1995")
815443200000
> date
Sat Nov 04 1995 00:00:00 GMT+0000 (GMT)

and now, arrays!
> new Array()
[]
> []
[]
> ["Jon", "Gerry"]
["Jon", "Gerry"]
> new Array("Jon", "Gerry")
["Jon", "Gerry"]
> my_array = ["general", "assembly"]
["general", "assembly"]
> my_array.length
2
> my_array[0]
"general"
> my_array.join(" ")
"general assembly"
> my_array.indexOf("general")
0
> my_array.indexOf("assembly")
1
> my_array.indexOf("nonexistent")
-1

more array functions that are just like ruby:
> my_array = ["orange", "banana", "watermelon"]
["orange", "banana", "watermelon"]
> my_array.slice(1)
["banana", "watermelon"]
> my_array.slice(0,2)
["orange", "banana"]
> my_array.pop()
"watermelon"
> my_array.push("apple")
3
> my_array
["orange", "banana", "apple"]
> my_array.reverse()
["apple", "banana", "orange"]
> my_array.shift()
"apple"
> my_array
["banana", "orange"]
> my_array.unshift("apple")
3
> my_array
["apple", "banana", "orange"]

there's math too:
> Math
MathConstructor {}
> Math.sqrt(9)
3
> [1,4,6,9].map(Math.sqrt)
[1, 2, 2.449489742783178, 3]
> [1,4,6,9].map(function(val) { return val + "boom" }) # return is not implicit in javascript when you're creating your own functions
["1boom", "4boom", "6boom", "9boom"]

> 1 + "boom"
"1boom"
> 1 + 1
2
> 1 + "1"
"11" # javascript sees a string and just assumes it should all just be converted into a string
> [1] + [2] # try to add two arrays
"12" # javascript just likes to convert everything into a string...
> [] + []
"" # javascript just likes to convert everything into a string...
> 1290804235784794376348637830851305636547
1.2908042357847944e+39  # big numbers get converted

> hash = { "a" : 1 }
Object {a: 1} # hash and object mean the same in javacsript
> hash.a # also the key can be a function
1

2. JAVASCRIPT:
--------------------------------

in javascript, there's + - * / %
but incrementation is a little different:
variable = 1
1
variable++
1 # print variable then add 1… post-incrementation
variable++
2
variable = 1
1
++variable
2 # pre-incrementation

comparisons: strict and not so strict
user_input = "10"
"10"
10 === user_input # strict comparison
false
10 == user_input
true

10 <= 20
true
10 >= 20
false
10 != 20
true
10 != "10"
false
10 !== "10"
true

false && true
false
false || true
true
false != true
true

boolean_value = true
true
final_value = boolean_value ? "yes" : "no";
"yes"
boolean_value = false
false
final_value = boolean_value ? "yes" : "no";
"no"

my_variable = 1
1
my_variable += 2
3
my_variable -= 2
1
my_variable = 1
1
my_variable *= 4
4
my_variable /= 10
0.4
my_variable = 10
10
my_variable %= 3
1

variable = 23
23
typeof variable
"number"
typeof 1
"number"
typeof "this"
"string"
typeof false
"boolean"
typeof []
"object"
typeof {}
"object"
typeof null
"object"
typeof boolean
"undefined"
a_variable_not_defined

ReferenceError: a_variable_not_defined is not defined
a_variable_defined_to_null = null
null
typeof a_variable_defined_to_null
"object"

alert("Hey dude!");
// in the window object

variable_storing_value_of_confirm = confirm("sure?");
// response: "ok" = true, "cancel" = "false"

variable_storing_value_of_confirm = confirm("sure?");
// response: "ok" = true, "cancel" = "false"

variable_storing_value_of_prompt = prompt("what's yo name?");

alert("Hi " + variable_storing_value_of_prompt + ", you said " + variable_storing_value_of_confirm);
// there's no string interpolation in javascript
// you normally only use alert in a page event that's really necessary

// no semi-colons required after curly braces for conditional statements
if(variable_storing_value_of_confirm == true){
  alert("nice!")
}
else{
  alert("gtfo!")
}


!!0
false
!!"0"
true
!!"1"
true
!!1
true
!!"false"
true

// javascript equivalent of case-when:

switch(variable_storing_value_of_prompt){
  case 17:
    alert("something");
    break;
  case 35:
    alert("ok");
    break;
}

switch(true){
  case (variable_storing_value_of_prompt > 17):
    alert("something");
    break;
  case (variable_storing_value_of_prompt > 35):
    alert("ok");
    break;
}

simple 'while':
var count = 0;
while(count < 10){
  console.log(count);
  count++;
}

'do...while' will execute at least once AND THEN evaluate that the condition to see if it should do it again:
var count = 0;
do{
  console.log(count + " logging");
  count++;
}while(count < 0)
returns:
0 logging

my_array = ["apple", "banana", "orange", "mango"]
for(i = 0; i < my_array.length; i++){
  console.log("fruit is ->" + my_array[i], i)
}

// for loops
my_array = ["apple", "banana", "orange", "mango"]
for(i = 0; i < my_array.length; i++){
  console.log("fruit is ->" + my_array[i], i)
}

// this exists but not very usable
for(value in my_array){
  console.log("2 - fruit is ->" + value)
}

for(i = 0; i < 5; i++){
  console.log(i)
}

typeof console.log
"function"

we use lower camel case in javascript naming

// my first js function
function sayHi(name) {
  console.log("Hi " + name + "!")
}

// confirm type of sayHi
sayHiType = typeof sayHi;
console.log("sayHi is a " + sayHiType);

functions are objects in javascript
you can call .toString, for instance:
sayHi.toString()
"function sayHi(name) {
  console.log("Hi " + name + "!")
}"

sayHi(99)
Hi 99! # javascript doesn't test the type you pass in…and we already know that javascript likes to convert things to string and add things together like that

// playing with function arguments...
function printArgs(foo, bar) {
  // we can capture named arguments
  console.log("\nfoo is " + foo + ", bar is " + bar);
  // there's a special array called arguments you just get from javascript
  for (i = 0; i < arguments.length; i++) {
    console.log("argument " + i + " is " + arguments[i])
  }
}
printArgs(99, "red balloons");
-----
result:
foo is 99, bar is red balloons
argument 0 is 99
argument 1 is red balloons

and you don't even need to pass both arguments:
  printArgs(99)
returns:
foo is 99, bar is undefined
argument 0 is 99


you can also pass more arguments than the function asked for:
  printArgs(99, "red balloons", "foo", 42);
foo is 99, bar is red balloons
argument 0 is 99
argument 1 is red balloons
argument 2 is foo
argument 3 is 42

// js functions return 'undefined' without an explicit return
function uselessSum(num1, num2) {
  num1 + num2
}
console.log("uselessSum(2,2) returned " + uselessSum(2,2));
----
returns:
uselessSum(2,2) returned undefined

function usefulSum(num1, num2) {
  return num1 + num2
}
console.log("usefulSum(2,2) returned " + usefulSum(2,2));
----
returns:
usefulSum(2,2) returned 4


variable scopes
what happens when you use "x = 99" vs. "var x = 99"?
``````````````````
x = 99;
y = 99;

function messWithMyVars() {
  x = "foo";
  console.log("x is " + x + " in the scope of messWithMyVars()")
}

function leaveMyVarsAlone() {
  var y = "bar";
  console.log("y is " + y + " in the scope of leaveMyVarsAlone()")
}

console.log("\nx is " + x + " in the global scope"); # 99
messWithMyVars(); # foo
console.log("\nx is now " + x + " in the global scope"); # foo

console.log("\ny is " + y + " in the global scope"); # 99
leaveMyVarsAlone(); # bar
console.log("\ny is still " + y + " in the global scope"); # 99
``````````````````

if you want to assign a function to a variable (like lambda or proc in ruby),
instead of:
  function sayHowdy() {}
we do:
  sayHowdy = function() {}
and we'd still call the method with sayHowdy()

// passing a function as an argument
function greetGerry(greetingFunction) {
  greetingFunction("Gerry")
}
greetGerry(sayHowdy); // not sayHowdy() here because we're passing the function itself and not the result of that function
greetGerry(sayHi);
--returns--
Howdy, Gerry!
Hi Gerry!

// returning a function (factory pattern: use one function to build another function)
function makeGreetingFunction(salutation) {
  return function(name) {
    console.log(salutation + " " + name + "!")
  }
}
sayHola = makeGreetingFunction("hola");
sayBonjour = makeGreetingFunction("bonjour");
sayBonjour("Julien");
sayHola("David");
--returns--
bonjour Julien!
hola David!

// javascript objects are a bit like a mash-up between a ruby hasn and a ruby object
obj = {foo: 99, bar: 100};
obj['foo'];    // hash-like getter
obj.foo;       // object-like getter
obj['baz'];    // hash-like setter
obj.baz = 101; // object-like setter
console.log(obj);
Object {foo: 99, bar: 100, baz: 101}

// we can use a function as a value in an object
// we then refer to it as a method
calc = {
  x: 2,
  y: 3,
  sum: function() { return this.x + this.y } // this. means current context, i.e. x=2, y=3, not whatever values you have defined for x and y in your console (the outer scope) before
}
console.log("the calc object has properties and methods ", calc);
````````
calc.sum();
5

let's add "console.log(this);" to see what "this" refers to in these contexts:
calc.sum();
Object {x: 2, y: 3, sum: function}
5
calc.sum.call(this); # override the function's x and y (this = function) with our window's x and y (this = window)
Window {top: Window, window: Window, location: Location, external: Object, chrome: Object…}
"foo99"


constructing objects with a functions:
````````````
// upper camel case for something that's essentially a class in ruby terms
function Person(options) {
  this.name = options.name;
  this.occupation = options.occupation;
  this.say = function(sentence) {
    console.log(this.name + " the " + this.occupation + " says: " + sentence)
  }
  return this
}
params = {name: "Jon", occupation: "instructor"};
jon = new Person(params);
jon.say("hello, WDI");
`````````````
Jon the instructor says: hello, WDI


build a basic calculator again!
````````````
function square(number) {
  return number * number // number**2 doesn't work in js
}

function cube(number) {
  return square(number) * number
}

function area(length, width) {
  return length * width
}

function getNumber(message) {
  return parseFloat(prompt(message)) // prompt for the message, which will be a string, then parse it as float (there's parseInteger too)
}

var response = prompt("(s)quare, (c)ube, (a)rea, or (q)uit: "); // use var because response is likely to be in the outer scope too
while(response != "q"){
 switch(response){
  case "s":
    var squared = square(getNumber("Enter number to square: "));
    alert("The square is: " + squared);
    break;
  case "c":
    var cubed = cube(getNumber("Enter number to cube: "));
    alert("The cube is: " + cubed);
    break;
  case "a":
    var length = getNumber("Enter length: ");
    var width = getNumber("Enter width: ");
    alert("The area is: " + area(length, width));
    break;
 }
 response = prompt("(s)quare, (c)ube, (a)rea, or (q)uit: "); // var not needed here
}
````````````

add to number to round to 2 decimal places:
.toFixed(2)

browser events, e.g. button onlick, dropdown on change

function basicCalc() {
  // get values from form (can get by element id and select box option value)
  var num1 = parseFloat(document.getElementById("basic-num-1").value); // document.getElementById("basic-num-1") gets us the reference of that element
  alert("typeof num1 is " + typeof num1);
  // var num2 = document.getElementById("basic-num-2");
  // var op = ;
  // perform calculation
  // update webpage to display answer
}
