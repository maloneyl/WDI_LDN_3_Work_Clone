$(function(){
  function hide(id) {
    $(id).hide()
  }

  function hideAllAnswers() {
    $.each(['#basic-answer','#trip-answer','#bmi-answer','#mortgage-answer'], function( index, value ) {
      hide(value)
    });
  }

  function unhide(id) {
    if($(id).hasClass("hide")) $(id).removeClass("hide")
    $(id).show()
  }

  function getValue(id) {
    return $(id).val()
  }

  function getFloat(id) {
    return parseFloat(getValue(id))
  }

  function roundToTwoDp(value) {
    return Math.round(value * 100) / 100
  }

  function setHtml(id, html) {
    $(id).html(html)
  }

  function basicCalc() {
    var num1 = getFloat("#basic-num-1");
    var num2 = getFloat("#basic-num-2");
    var op   = getValue("#basic-operation");

    switch(op){
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
    setHtml("#basic-answer-alert", num1 + " " + op + " " + num2 + " = " + ans);
    hideAllAnswers();
    unhide("#basic-answer");
  }

  function tripCalc() {
    var dist  = getFloat("#trip-distance");
    var mpg   = getFloat("#trip-mpg");
    var cost  = getFloat("#trip-cost");
    var speed = getFloat("#trip-speed");

    time = roundToTwoDp(dist / speed);

    if (mpg > 60) {
      var actualMpg = mpg - (speed - 60) * 2;
    } else {
      var actualMpg = mpg;
    }

    cost = roundToTwoDp(dist / actualMpg * cost);

    setHtml("#trip-answer-alert", "Your trip will take " + time + " hours and cost $" + cost + ".");
    hideAllAnswers();
    unhide("#trip-answer");
  }

  function changeBmiUnits() {
    var units = getValue("#bmi-units");

    switch(units){
      case 'metric':
        setHtml("#bmi-mass-unit", "kg");
        setHtml("#bmi-height-unit", "m");
        break;
      case 'imperial':
        setHtml("#bmi-mass-unit", "lb");
        setHtml("#bmi-height-unit", "in");
        break;
    }

    hide('#bmi-answer');
  }

  function bmiCalc() {
    var units  = getValue("#bmi-units");
    var mass   = getFloat("#bmi-mass");
    var height = getFloat("#bmi-height");

    switch(units){
      case 'metric':
        var bmi = roundToTwoDp(mass / Math.pow(height/100, 2));
        break;
      case 'imperial':
        var bmi = roundToTwoDp(mass / Math.pow(height, 2) * 703);
        break;
    }

    setHtml("#bmi-answer-alert", "your BMI is " + bmi);
    hideAllAnswers();
    unhide("#bmi-answer");
  }

  function mortgageCalc() {
    var loan = getFloat("#mortgage-loan");
    var apr  = getFloat("#mortgage-apr")/100/12;
    var term = getFloat("#mortgage-term");

    temp = Math.pow((1 + apr), term);
    payment = roundToTwoDp(loan * apr * temp / (temp - 1));

    setHtml("#mortgage-answer-alert", "your monthly payments will be &pound;" + payment + " each");
    hideAllAnswers();
    unhide("#mortgage-answer");
  }

  $("#basic-calc").on("click", basicCalc);
  $("#trip-calc").on("click", tripCalc);
  $("#bmi-units").on("change", changeBmiUnits);
  $("#bmi-calc").on("click",bmiCalc);
  $("#mortgage-calc").on("click", mortgageCalc);
})
