// UNIVERSALLY USEFUL FUNCTIONS HERE

function hideAllAnswers() {
  $('div[id$=answer]').each // id$ means id name ending with
    (function(index, value){
      $(this).attr('class', 'hide');}
    );
}

// ACTUAL CALCULATOR STUFF BELOW

function basicCalc() {

  // 1. get values
  $num1 = parseFloat($('#basic-num-1').val());
  $num2 = parseFloat($('#basic-num-2').val());
  $op = $('#basic-operation').val();

  // 2. calculate
  switch($op) {
    case '+':
      $ans = $num1 + $num2;
      break;
    case '-':
      $ans = $num1 - $num2;
      break;
    case '*':
      $ans = $num1 * $num2;
      break;
    case '/':
      $ans = $num1 / $num2;
      break;
  }

  // 3. display
  $('#basic-answer-alert').text($num1 + " " + $op + " " + $num2 + " = " + $ans.toFixed(2));
  hideAllAnswers();
  $('#basic-answer').attr('class', '');
} // end of basicCalc

function tripCalc() {

  // 1a. get values
  $distance = parseFloat($('#trip-distance').val());
  $mpg = parseFloat($('#trip-mpg').val());
  $costOfGas = parseFloat($('#trip-cost').val());
  $speed = parseFloat($('#trip-speed').val());

  // 1b. get real mpg if too fast
  if($speed > 60) {
    $tooFastForMpg = $speed - 60;
    $mpg = $mpg - ($tooFastForMpg * 2);
  }

  // 2. calculate result
  $howLong = $distance / $speed;
  $howMuch = $costOfGas / $mpg * $distance;

  // 3. display answer on webpage
  $('#trip-answer-alert').text("Your trip will take " + $howLong.toFixed(2) + " hours and cost $" + $howMuch.toFixed(2) + ".");
  hideAllAnswers();
  $('#trip-answer').attr('class', '');
} // end tripCalc

// update units on webpage labels, not calculation
function changeBmiUnits() {
  $('#bmi-mass-unit').text('lb');
  $('#bmi-height-unit').text('in');
  // below is just so the user can go back to metric (once)
  $('#bmi-units').on('change', function() {
    $('#bmi-mass-unit').text('kg');
    $('#bmi-height-unit').text('cm');
  });
} // end changeBmiUnits

function bmiCalc() {

  // 1. get values
  $weight = parseFloat($('#bmi-mass').val());
  $height = parseFloat($('#bmi-height').val());
  $units = $('#bmi-units').val();

  // 2. determine units and calculate result with unit-appropriate formula
  switch($units) {
    case 'metric':
      $bmi = $weight / Math.pow($height/100, 2);
      break;
    case 'imperial':
      $bmi = $weight / Math.pow($height, 2) * 703;
      break;
  }

  // 3. display result on webpage
  $('#bmi-answer-alert').text("Your BMI is " + $bmi.toFixed(2) + ".");
  hideAllAnswers();
  $('#bmi-answer').attr('class', '');
} // end bmiCalc

function mortgageCalc() {
  // 1a. get values
  var principalAmount = parseFloat($('#mortgage-loan').val());
  var interestRate = parseFloat($('#mortgage-apr').val());
  var loanTerm = parseFloat($('#mortgage-term').val());

  // 1b. convert interest_rate (APR) into monthly rate
  var i = interestRate / 100 / 12;

  // 2. calculate result
  // reference: Math.pow(4,3) is 4**3
  // monthly payment = p * ( i * (1 + i)**n ) / ( (1 + i)**n - 1 )
  var monthlyPayment = principalAmount *
    ( i * Math.pow((1+i), loanTerm) ) / ( Math.pow((1+i), loanTerm) - 1 );

  // 3. display answer on webpage
  // pound sign: \u00a3
  $('#mortgage-answer-alert').text("Your monthly payment is \u00a3" + monthlyPayment.toFixed(2) + ".");
  hideAllAnswers();
  $('#mortgage-answer').attr('class', '');

} // end mortgageCalc

