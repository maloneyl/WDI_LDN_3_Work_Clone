# we'll rewrite advanced calc in coffeescript here...

$ ->

  basicCalc = ->
    $("#basic-answer-alert").text "need to implement basicCalc"
    $("#basic-answer").removeClass "hide"

  tripCalc = ->
    $("#trip-answer-alert").text "need to implement tripCalc"
    $("#trip-answer").removeClass "hide"

  changeBmiUnits = ->
    $("#bmi-answer-alert").text "need to implement changeBmiUnits"
    $("#bmi-answer").removeClass "hide"

  bmiCalc = ->
    $("#bmi-answer-alert").text "need to implement bmiCalc"
    $("#bmi-answer").removeClass "hide"

  mortgageCalc = ->
    $("#mortgage-answer-alert").text "need to implement mortgageCalc"
    $("#mortgage-answer").removeClass "hide"

  $("#basic-calc").on     "click",  basicCalc
  $("#trip-calc").on      "click",  tripCalc
  $("#bmi-units").on      "change", changeBmiUnits
  $("#bmi-calc").on       "click",  bmiCalc
  $("#mortgage-calc").on  "click",  mortgageCalc