// UNIVERSALLY USEFUL FUNCTIONS HERE

// get value from form (can get by element id and select box option value)
function getValue(id) {
  return document.getElementById(id).value // document.getElementById("basic-num-1") gets us the reference of that element; .value gets us the actual value
}

// turn string value to float
function getFloat(id) {
  return parseFloat(getValue(id))
}

// unhide answer box (e.g. <div id="basic-answer" class="hide">)
function unhide(id) {
  document.getElementById(id).className = "" // crude way...just replacing class="hide" to class=""
}

// set html to change content on webpage to display answers and units
function setHtml(id, html) {
  document.getElementById(id).innerHTML = html
}


// ACTUAL CALCULATOR STUFF BELOW

function basicCalc() {
  // step 1: get values from form (can get by element id and select box option value)
  var num1 = getFloat('basic-num-1');
  var num2 = getFloat('basic-num-2');
  var op = getValue('basic-operation');

  // alert("num1 is " + num1);
  // alert("typeof num1 is " + typeof num1);

  // step 2: perform calculation
  switch(op) {
    case '+':
      var ans = num1 + num2;
      break;
    case '-':
      var ans = num1 - num2;
      break;
    case '*':
      var ans = num1 * num2;
      break;
    case '/':
      var ans = num1 / num2;
      break;
  }

  // step 3: update webpage to unhide the answer box and display answer
  // alert("answer = " + ans.toFixed(2));
  setHtml('basic-answer-alert', num1 + " " + op + " " + num2 + " = " + ans.toFixed(2));
  unhide('basic-answer'); // the unhide method is what we've just written at the top

} // end of basicCalc

function tripCalc() {}

// update units on webpage labels, not calculation
function changeBmiUnits() {}

function bmiCalc() {}

function mortgageCalc() {}
