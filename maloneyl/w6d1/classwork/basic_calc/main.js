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

// add onload so we'll always see that text in the html body
window.onload = function() {
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
      alert("The area is: " + area(length, width).toFixed(2));
      break;
   }
   response = prompt("(s)quare, (c)ube, (a)rea, or (q)uit: "); // var not needed here
  }
}
