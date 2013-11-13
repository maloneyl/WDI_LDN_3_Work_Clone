# we'll rewrite advanced calc in coffeescript here...

$ ->

  hide = (id) ->
    $(id).hide()

  hideAllAnswers = ->
    hide value for value in ['#basic-answer','#trip-answer','#bmi-answer','#mortgage-answer']

  unhide = (id) ->
    $(id).removeClass "hide" if $(id).hasClass "hide"
    $(id).show()

  getValue = (id) ->
    $(id).val()

  getFloat = (id) ->
    parseFloat(getValue id)

  roundToTwoDp = (value) ->
    Math.round(value * 100) / 100

  setHtml = (id, html) ->
    $(id).html html

  basicCalc = ->
    num1 = getFloat "#basic-num-1"
    num2 = getFloat "#basic-num-2"
    op = getValue "#basic-operation"

    ans = switch op
      when "+" then num1 + num2
      when "-" then num1 - num2
      when "*" then num1 * num2
      when "/" then num1 / num2

    setHtml "#basic-answer-alert", "#{num1} #{op} #{num2} = #{roundToTwoDp(ans)}"
    hideAllAnswers()
    unhide "#basic-answer"

  tripCalc = ->
    dist  = getFloat "#trip-distance"
    mpg   = getFloat "#trip-mpg"
    cost  = getFloat "#trip-cost"
    speed = getFloat "#trip-speed"

    time  = roundToTwoDp(dist / speed)

    actualMpg = switch mpg
      when (mpg > 60) then mpg - (speed - 60) * 2
      else mpg

    cost = roundToTwoDp(dist / actualMpg * cost)

    setHtml "#trip-answer-alert", "Your trip will take #{time} hours and cost $#{cost}."
    hideAllAnswers()
    unhide "#trip-answer"

  changeBmiUnits = ->
    units = getValue "#bmi-units"

    switch units
      when "metric"
        setHtml "#bmi-mass-unit", "kg"
        setHtml "#bmi-height-unit", "m"
      when "imperial"
        setHtml "#bmi-mass-unit", "lb"
        setHtml "#bmi-height-unit", "in"

    hide "#bmi-answer"

  bmiCalc = ->
    units = getValue "#bmi-units"
    mass = getFloat "#bmi-mass"
    height = getFloat "#bmi-height"

    bmi = switch units
      when "metric" then roundToTwoDp(mass / Math.pow(height/100, 2))
      when "imperial" then roundToTwoDp(mass / Math.pow(height, 2) * 703)

    setHtml "#bmi-answer-alert", "Your BMI is #{bmi}."
    hideAllAnswers()
    unhide "#bmi-answer"

  mortgageCalc = ->
    loan = getFloat "#mortgage-loan"
    apr = getFloat("#mortgage-apr")/100/12
    term = getFloat "#mortgage-term"

    temp = Math.pow((1 + apr), term)
    payment = roundToTwoDp(loan * apr * temp / (temp - 1))

    setHtml "#mortgage-answer-alert", "Your monthly payments will be &pound;#{payment} each."
    hideAllAnswers()
    unhide "#mortgage-answer"

  $("#basic-calc").on     "click",  basicCalc
  $("#trip-calc").on      "click",  tripCalc
  $("#bmi-units").on      "change", changeBmiUnits
  $("#bmi-calc").on       "click",  bmiCalc
  $("#mortgage-calc").on  "click",  mortgageCalc
