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

function tripCalc() {

  // 1a. get values
  var distance = getFloat('trip-distance');
  var mpg = getFloat('trip-mpg');
  var cost_of_gas = getFloat('trip-cost');
  var speed = getFloat('trip-speed');

  // 1b. get real mpg if too fast
  if(speed > 60) {
    too_fast_for_mpg = speed - 60;
    mpg = mpg - (too_fast_for_mpg * 2);
  }

  // 2. calculate result
  how_long = distance / speed;
  how_much = cost_of_gas / mpg * distance;

  // 3. display answer on webpage
  setHtml('trip-answer-alert', "Your trip will take " + how_long.toFixed(2) + " hours and cost $" + how_much.toFixed(2) + ".");
  unhide('trip-answer');

} // end tripCalc

// update units on webpage labels, not calculation
function changeBmiUnits() {}

function bmiCalc() {}

function mortgageCalc() {
  // 1a. get values
  var principal_amount = getFloat('mortgage-loan');
  var interest_rate = getFloat('mortgage-apr');
  var loan_term = getFloat('mortgage-term');

  // 1b. convert interest_rate (APR) into monthly rate
  var i = interest_rate / 100 / 12;

  // 2. calculate result
  // reference: Math.pow(4,3) is 4**3
  // monthly payment = p * ( i * (1 + i)**n ) / ( (1 + i)**n - 1 )
  var monthly_payment = principal_amount *
    ( i * Math.pow((1+i), loan_term) ) / ( Math.pow((1+i), loan_term) - 1 )

  // 3. display answer on webpage
  // pound sign: \u00a3
  setHtml('mortgage-answer-alert', "Your monthly payment is \u00a3"+ monthly_payment.toFixed(2) + ".");
  unhide('mortgage-answer');

} // end mortgageCalc
