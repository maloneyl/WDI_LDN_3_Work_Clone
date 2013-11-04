// my first js function
function sayHi(name) {
  console.log("Hi " + name + "!")
}

// confirm type of sayHi
sayHiType = typeof sayHi;
console.log("sayHi is a " + sayHiType);

// try these in console
sayHi("Jon");
sayHi;
sayHi.toString();

// function arguments aren't strongly typed
sayHi(99);
// returns "Hi 99!" because javascript likes to convert stuff to string

// new function to separate things
function drawHeader(name) {
  console.info("\n**********" + name + "**********\n")
}

//////////////
drawHeader("function arguments");

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
printArgs(99);
printArgs(99, "red balloons", "foo", 42);

/////////////////////////////////////
drawHeader("return values");

// js functions return 'undefined' without an explicit return
function uselessSum(num1, num2) {
  num1 + num2
}
console.log("uselessSum(2,2) returned " + uselessSum(2,2));

function usefulSum(num1, num2) {
  return num1 + num2
}
console.log("usefulSum(2,2) returned " + usefulSum(2,2));

////////////////////////////////////
drawHeader("variable scope");

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

console.log("\nx is " + x + " in the global scope");
messWithMyVars();
console.log("\nx is now " + x + " in the global scope");

console.log("\ny is " + y + " in the global scope");
leaveMyVarsAlone();
console.log("\ny is still " + y + " in the global scope");

////////////////////////////////////
drawHeader("functions as variables");

// assign a function to a variable
// this is like lambda or proc in ruby
// instead of function sayHowdy() {}
// do this
sayHowdy = function(name) {
  console.log("Howdy, " + name + "!")
}
sayHowdy("Gerry");

// passing a function as an argument
function greetGerry(greetingFunction) {
  greetingFunction("Gerry")
}
greetGerry(sayHowdy); // not sayHowdy() here because we're passing the function itself and not the result of that function
greetGerry(sayHi);

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

////////////////////////////////////
drawHeader("REMINDER: objects");

// javascript objects are a bit like a mash-up between a ruby hasn and a ruby object
obj = {foo: 99, bar: 100};
obj['foo'];    // hash-like getter
obj.foo;       // object-like getter
obj['baz'];    // hash-like setter
obj.baz = 101; // object-like setter
console.log(obj);

////////////////////////////////////
drawHeader("functions as object methods");

// we can use a function as a value in an object
// we then refer to it as a method
calc = {
  x: 2,
  y: 3,
  sum: function() {
    console.log(this);
    return this.x + this.y // this. means current context, i.e. x=2, y=3, not whatever values you have defined for x and y in your console/window before
  }
}
console.log("the calc object has properties and methods ", calc);
console.log("calc.sum() returns " + calc.sum());

////////////////////////////////////
drawHeader("constructing objects with a functions");

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
console.log("the job object has properies and methods ", jon);
jon.say("hello, WDI");

