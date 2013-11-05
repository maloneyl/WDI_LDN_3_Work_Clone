function drawHeader(name) {
  console.info("\n**************** " + name + " ****************\n")
}


/////////////////////////////////////////////////////////////////////
drawHeader("the jQuery object");

// jQuery adds two variables to the global scope

console.log('jQuery is a ' + typeof jQuery);
console.log('$ is a ' +  typeof $);
console.log('jQuery and $ are the same object? ' + (jQuery == $));


/////////////////////////////////////////////////////////////////////
drawHeader("document ready");

function onloadFunc1() {
  console.log('\n The 1st onload func was triggered.')
}

function onloadFunc2() {
  console.log('\n The 2nd onload func was triggered.')
}

function onloadFuncWrapper() {
  onloadFunc1();
  onloadFunc2();
}

function docReadyFunc1() {
  console.log('\n The 1st doc ready func was triggered.')
}

function docReadyFunc2() {
  console.log('\n The 2nd doc ready func was triggered.')
}

// the vanilla js way of waiting for the document to load
// this waits for EVERYTHING to load, e.g. big images
// we can only call one function so we'll wrap both onloadFunc1 and onloadFunc2 into onloadFuncWrapper()
window.onload = onloadFuncWrapper;

// the jQuery way
// this only waits for the document's STRUCTURE to load (i.e. the body, divs, etc.)
// and we can chain methods/calls together (like method-chaining in ruby), no need to make a wrapper!
// e.g. one-line as $('document').ready(docReadyFunc1).ready(docReadyFunc2)
// or clearer, multi-line as below (but must have semi-colon after the last one)
$('document')
  .ready(docReadyFunc1)
  .ready(docReadyFunc2)
  .ready(runExperiments);

function runExperiments() {

  /////////////////////////////////////////////////////////////////////
  drawHeader("getting page content");

  // the vanilla js DOM API lets us grab elemetns by tag type
  // we get an array of plain DOM element objects
  // e.g.
  paras = document.getElementsByTagName('p');
  paras[0];
  paras[1];
  // now in the console we'll be able to access paras, paras[0], paras[1], assign a variable firstP to paras[0] to then call native functions on firstP

  // jQuery lets us do this more concisely AND wraps the element in a jQuery object
  $paras = $('p'); // returns an array; $paras is a variable name starting with $, not a function call
  $paras[0];
  $paras[1];
  // now in the console we can access $paras simimarly as above, but $paras. gives us many more functions

  $images = $('img'); // returns an array of all images, blessed with jQuery superpowers

  // we can basically use any CSS selectors in $()

  // simple id lookup
  $planetList = $('#planet-list'); // we use # for id here as in normal CSS; ln 17 in index.html: <ul id="planet-list">

  // hierarchical css selectors are ok too
  // the same thing in vanilla js would require loops
  $gasGiantListItems = $('li.gas-giant'); // from lns 22-25: <li class="gas-giant">Jupiter</li> etc.
  $contentHeadings = $('#content > h1'); // CSS: '#content > h1' means only immediate level of h1 after #content, not any deeper

  // we can also use jQuery helpers
  $planetListItems = $planetList.children();

  // we can get the raw DOM elements from a set of jQuery objects
  firstPlanet = $planetListItems[0]; // returns plain DOM element; firstPlanet is depowered
  $planetListItems.first();
  $planetListItems.last();

  // if we need to re-wrap a raw DOM element
  $firstPlanet = $(firstPlanet); // i.e. $(thatDepoweredThing) means getting superpowers back!

  // we can easily get info about elements using jQuery
  height = $images.height(); // if you don't specify the item wanted in $images (an array of all images), jQuery will apply it to the first one
  console.log('\nThe height of the first (assumed) image is: ' + height);

  color = $gasGiantListItems.css('color'); // again, assumes first item when none specified; returns "rgb(0, 0, 0)" like normal css 'color'
  console.log('\nThe color of the first (assumed) planet list item is: ' + color);

  console.log('\nThe text of the first planet li is: ' + $firstPlanet.text); // get the actual text from $firstPlanet


  /////////////////////////////////////////////////////////////////////
  drawHeader("manipulating page content");

  // reminder: getting stuff from CSS:
  // $gasGiantListItems.css('color')
  // >> "rgb(0, 0, 0)"
  // to SET stuff, just need to pass one more argument
  // $gasGiantListItems.css('color', 'red')
  // >> [
      // <li class=​"gas-giant" style=​"color:​ red;​">​Jupiter​</li>​ // jQuery added that inline CSS
      // ,
      // <li class=​"gas-giant" style=​"color:​ red;​">​Saturn​</li>​
      // ,
      // <li class=​"gas-giant" style=​"color:​ red;​">​Uranus​</li>​
      // ,
      // <li class=​"gas-giant" style=​"color:​ red;​">​Neptune​</li>​
      // ]

  // we can easily style element sets by chaining
  $gasGiantListItems
    .css('color', 'red')
    .css('font-weight', 'bold');

  // we can also loop through sets
  // useful if we need to do different things to each element
  function addPlanetClass(index) {
    // // console.log(index, this);
    // console.log(index, $(this).text());
      $(this).addClass("planet-" + (index+1)); // we need this to be $(this) to use addClass method, which expects argument of a string of class name (in our case, we want planet-1, planet-2, etc.)

    // more addClass action in console as example of how addClass works:
    // $('#content')
    // >> [<section id=​"content">​…​</section>​]
    // $('#content').addClass("awesome")
    // >> [<section id=​"content" class=​"awesome">​…​</section>​]
  }
  $planetListItems.each(addPlanetClass); // we want to name each planet's class: planet-1, planet-2, etc.

  // and thanks to the individual classes, we can now edit our planet list selectively:
  $('.planet-9').append(" (not classed as a planet anymore)")
  // returns:
    // [
    //   <li class=​"rocky-planet planet-9">​
    //   "Pluto"
    //   " (not classed as a planet anymore)"
    //   </li>​
    // ]
  $('.planet-3').text("Earth - home sweet home")
  // returns:
    // [
    //   <li class=​"rocky-planet planet-3">​Earth - home sweet home​</li>​
    // ]
  $('.planet-4').html("Mars - has rovers: <ul><li>Spirit</li></ul>")
  // returns:
    // [
    //   <li class=​"rocky-planet planet-4">​
    //   "Mars - has rovers: "
    //   <ul>​
    //   <li>​Spirit​</li>​
    //   </ul>​
    //   </li>​
    // ]


  /////////////////////////////////////////////////////////////////////
  drawHeader("events");

  function displayImageSrc() {
    console.log("src is: " + $(this).attr('src')); // and if we do .attr('src', 'http://....'), it becomes a setter function
  }

  $images.on('click', displayImageSrc); // this means, when you click on an image, you'll see the console message


  /////////////////////////////////////////////////////////////////////
  drawHeader("animation");

  function makeImageBig() {
    $(this).animate( // take 3 arguments, so we'll do that on multiple lines like this:
        {height: '600px'}, // a hash of what to do, with valid css
        5000, // milliseconds
        function(){console.log('just resized an image')} // what the big finish should be
      )
  }

  $images.on('dblclick', makeImageBig); // 'dblclick' is double-click

}
