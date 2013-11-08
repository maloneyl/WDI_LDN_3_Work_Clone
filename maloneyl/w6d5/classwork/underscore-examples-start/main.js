// functions we'll be using

function drawHeader(name) {
  console.info("\n************** " + name + " **************\n")
}

function appendHtml(html) {
  main = document.getElementById("main");
  main.innerHTML = main.innerHTML + html;
}

window.onload = function(){

///////////////////////////////////////////////////////////
drawHeader("Collections");

/// _.each
// this does the same job as each in ruby

names = ["Alice", "Bob", "Charlie", "Daisy"];

// in ruby, we'd do: names.each { |name| "Hello, #{name}!" }
// underscore is similar:
// syntax 1:
console.log("Using _.each(array, func): ");
_.each(names, function(name){ console.log("Hello, " + name + "!") });

// syntax 2:
console.log("\nUsing _(array).each(func): ");
_(names).each(function(name){ console.log("Hello, " + name + "!") });


/// _.map
// similar to ruby, returns an array with the new items
greetings = _(names).map(
  function(name){ return "Hello, " + name + "!" }
  );
console.log("\nMade this with map:", greetings);

/// _.reduce
nums = [1, 2, 3, 4];

// in ruby, we'd do: nums.reduce(0) { |memo, num| memo + num }
// the 0 passed in is the starting memo and 1 is the first num
// then the memo becomes the result of 0 + the first num
// and the result of the function at the end is 10

sum = _(nums).reduce(
  function(memo, num){ return memo + num }, // reminder: need explicit return in js, even when using underscore
  0) // passing the memo
console.log("\nFound sum using reduce:", sum);
// BTW, ("\nFound sum using reduce:", sum) is different from ("\nFound sum using reduce:" + sum)
// because "+" will turn the sum into a string

/// reduceRight

/// find
students = [
  {name: "Alice",   age: 32, nationality: "British"},
  {name: "Bob",     age: 23, nationality: "British"},
  {name: "Charlie", age: 32, nationality: "British"},
  {name: "Daisy",   age: 45, nationality: "American"}
];

firstBrit = _(students).find(
  function(s){ return s.nationality == "British" }
  );
console.log("\nFound first Brit using find: ", firstBrit);

/// filter
allBrits = _(students).filter(
  function(s){ return s.nationality == "British" }
  );
console.log("\nFound all Brits using filter: ", allBrits, "\nand the first one is named ", allBrits[0].name, " and aged ", allBrits[0].age);

/// where
// match on specific values (i.e. cannot pass in "age: >30")
britsAged32 = _(students).where({
  nationality: "British",
  age: 32
})
console.log("\nFound all Brits aged 32 using where: ", britsAged32);

/// findWhere

/// reject

/// every
// like .all? in ruby: students.all? { |s| s.age > 16 }
// also returns true or false
allOver16 = _(students).every(
  function(s){ return s.age > 16}
  );
console.log("\nChecked all over 16 using every:", allOver16);

/// some
// like .any? in ruby

/// contains

/// invoke

/// pluck
// returns an array with the values of the key wanted
ages = _(students).pluck("age");
console.log("\nPlucked all ages using pluck: ", ages);

/// max
oldest = _(students).max(
  function(s){ return s.age }
  );
console.log("\nFound oldest student using max: ", oldest);

/// min

/// sortBy
// syntax 1:
studentsByAge = _(students).sortBy("age"); // native sort order, i.e. ascending
// syntax 2:
studentsByAge = _(students).sortBy(
  function(s) { return s.age } // -s.age would give us descending order
  );
console.log("\nStudents sorted by age using sortBy: ", studentsByAge);

/// groupBy

/// indexBy

/// countBy

/// shuffle

/// sample
randomPairOfStudents = _(students).sample(2);
randomStudent = _(students).sample(); // 1 is assumed if nothing passed
console.log("\nPicked this pair of students randomly using sample: ", randomPairOfStudents);
console.log("\nPicked this student randomly too using sample: ", randomStudent);

/// toArray

/// size

///////////////////////////////////////////////////////////
drawHeader("Arrays");

array = [1, 2, 2, ["foo", "bar"], false, 0, "", NaN, null, undefined, 100];

/// first
// like .first in ruby
firstTwo = _(array).first(2);
console.log("\nFound first two elements in array using first: ", firstTwo);

/// initial

/// last
lastOne = _(array).last(); // 1 is assumed if nothing passed
console.log("\nFound last element in array using last: ", lastOne);

/// rest

/// compact
// like .compact in ruby, but ruby just has false and nil
// js has more falsey values: false, 0, "", NaN, null, defined
// yes, even 0 is false
nonFalseyValues = _(array).compact();
console.log("\nFound and removed all falsey values using compact: ", nonFalseyValues);


/// flatten
// like .flatten in ruby, turning items in nested array into items in main array
flattened = _(array).flatten();
console.log("\nFlattened array with flatten: ", flattened);

/// without

/// union

/// intersection
// in ruby: [1,2,3] & [1,2] => [2,3]
commonElements = _(array).intersection([1, 2, 100]); // pass in what you want in common
console.log("\nFound common elements with intersection: ", commonElements);

/// difference

/// uniq

/// zip

/// object

/// indexOf

/// lastIndexOf

/// sortedIndex

/// range
myRanges = [
  _.range(10), // returns array: 0, 1, .., 9
  _.range(1, 11), // returns array: 1, 2, .., 10
  _.range(0, 30, 5), // returns array of 0,5,10...25; 3rd arg is step; 2nd arg is up-to-but-exclude
  _.range(0, -10, -1), // returns array: 0, -1, -2, .., -9
  _.range(0) // returns empty array
];
console.log("\nMade these ranges using range: ", myRanges)

///////////////////////////////////////////////////////////
drawHeader("Functions");

/// bind

/// bindAll

/// partial

/// memoize

/// delay
// calls setTimeout for us
_.delay(function(){
  appendHtml("Created this delayed message with delay!\n")},
  1000);
console.log("\nKeep an eye out for a delayed message in the browser...");

/// defer

/// throttle
// VERY USEFUL!
function addMouseMessage(){
  appendHtml("MOUSEOVER!");
}
throttledAddMouseMessage = _.throttle(addMouseMessage, 500); // 500 refers to 500ms, means make it throttle 2x per second (1000/500)
document.getElementById("main").onmouseover = throttledAddMouseMessage;

/// debounce

/// once

/// after

/// wrap

/// compose

///////////////////////////////////////////////////////////
drawHeader("Objects");

/// keys
obj = {one: 1, two: 2, three: 3};

keys = _(obj).keys();
console.log("\nGot object keys with keys: ", keys);

/// values
values = _(obj).values();
console.log("\nGot object values with values: ", values);

/// pairs
// array of key-and-value pair
pairs = _(obj).pairs();
console.log("\nGot object pairs with pairs: ", pairs);

/// invert

/// functions

/// extend

/// pick

/// omit

/// defaults
// VERY USEFUL!
passedOptions = {transitionDuration: 800};
defaultOptions = {
  transitionDuration: 200,
  loop:               true,
  slideshow:          false,
  waitTime:           1000
};
options = _(passedOptions).defaults(defaultOptions);
console.log("\nMerged passed and default options using defaults: ", options);

/// clone

/// tap

/// has

/// isEqual

/// isEmpty

/// isElement

/// isArray

/// isObject

/// isArguments

/// isFunction

/// isString

/// isNumber

/// isFinite

/// isBoolean

/// isDate

/// isRegExp

/// isNaN

/// isNull

/// isUndefined

///////////////////////////////////////////////////////////
drawHeader("Utility");

/// noConflict
/// identity
/// times
/// random
/// mixin
/// uniqueId
/// escape
/// unescape
/// result

/// template

helloWorld = _.template("Hello, <em><%= name %></em>!", {name: "world"});
// if we don't pass that 2nd arg {name: "world"} above, we'll just have the template stored as a function and pass in data later
console.log("\nMade the following HTML using template: ", helloWorld);
appendHtml(helloWorld);

// to make a template equivalent to erb:
// <h2>Students</h2>
// <ul>
//   <% students.each do |s| %>
//     <li><%= s.name %></li>
//   <% end %>
// </ul>'

// use single quotes to bracket our template text because we often have double-quoted stuff within our html
// write in multi-line first so it's clearer to us:
// compiledTemplate = _.template('
//   <h2>Students</h2>
//   <ul>
//     <% _(students).each(function(s){ %>
//       <li><%= s.name %></li>
//     <% }) %>
//   </ul>
//   ');
// note <% }) %> is effectively <% end %>
// but because javascript is terrible, we actually need to delete all the white space afterwards and make it all on one line

compiledTemplate = _.template('<h2>Students</h2><ul><% _(students).each(function(s){ %><li><%= s.name %></li><% }) %></ul>');
renderedTemplate = compiledTemplate({students: students});
appendHtml(renderedTemplate);

///////////////////////////////////////////////////////////
drawHeader("Chaining");

lines = [
  {num: 1, words: "I'm a lumberjack and I'm okay"},
  {num: 2, words: "I sleep all night and I work all day"},
  {num: 3, words: "He's a lumberjack and he's okay"},
  {num: 4, words: "He sleeps all night and he works all day"}
];

// painful version: word count with underscore, not using chaining
lineWords = _(lines).map(
  function(line){ return line.words.split(" ") }
  );
console.log(lineWords);
allWords = _(lineWords).flatten();
console.log(allWords);
wordCount = _(allWords).reduce(
  function(counts, word){ // reduce's 1st arg is the function
    counts[word] = (counts[word] || 0) + 1; // counts[word] || 0 means initializing counts[word] the first time
    return counts;
  },
  {} // reduce's 2nd arg is the initial value of counts (memo)
  );
console.log("\nCounted the number of times each word appears without using chaining: ", wordCount);

// word count with underscore, using chaining this time:
chainedWordCount = _.chain(lines) // pass in original item we'll be chaining stuff to; alt. syntax: _(lines).chain()
  .map(function(line){ return line.words.split(" ") })
  .flatten()
  .reduce(function(counts, word){
    counts[word] = (counts[word] || 0) + 1;
    return counts;
  }, {}).value(); // note: need .value() here!
console.log("\nCounted the number of times each word appears using chaining this time: ", chainedWordCount);

// word count with just javascript... no, don't do it

/// chain

/// value

} // end of window.onload
