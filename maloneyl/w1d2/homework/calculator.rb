def basic_calc

  op_good = false
  while op_good == false
    puts "Would you like to add, subtract, multiply or divide two numbers?"
    puts "Press a to add, s to subtract, etc."
    op = gets.chomp.strip.downcase
    op_good = true if (op == "a" || op == "s" || op == "m" || op == "d")
  end

  puts "Enter the first number:"
  first_number = gets.chomp.to_i

  puts "Enter the second number:"
  second_number = gets.chomp.to_i

  case op
  when "a"
    puts "#{first_number} + #{second_number} = #{first_number + second_number}"
  when "s"
    puts "#{first_number} - #{second_number} = #{first_number - second_number}"
  when "m"
    puts "#{first_number} * #{second_number} = #{first_number * second_number}"
  when "d"
    puts "#{first_number} / #{second_number} = #{first_number / second_number}"
  end

end


def mortgage_calc

  puts "Enter the principal amount ($):"
  p = gets.chomp.to_f
  
  puts "Enter the yearly interest rate (%):"
  i = gets.chomp.to_f / 100 / 12 # turn x% into decimal then into monthly rate

  puts "Enter your loan terms in years:" # not assuming user will compute number of payments
  n = gets.chomp.to_f * 12 

  monthly_payment = p * ( i * (1 + i)**n ) / ( (1 + i)**n - 1 )

  puts "Your mortgage payment is $#{monthly_payment.round(2)} a month."

end


def bmi_calc

  unit_good = false
  while unit_good == false
  puts "Enter m for metric and i for imperial:"
  unit = gets.chomp.strip.downcase
    unit_good = true if (unit == "m" || unit == "i")
  end
  
  case unit
  when "m"
    puts "Enter your weight in kilos:"
    weight = gets.chomp.to_f
    puts "Enter your height in metres:"
    height = gets.chomp.to_f
    bmi = weight / height**2
  when "i"
    puts "Enter your weight in lbs:"
    weight = gets.chomp.to_f
    puts "Enter your height in inches:"
    height = gets.chomp.to_f
    bmi = weight / height**2 * 703
  end

  puts "Your BMI is #{bmi}."

end


def trip_calc
  
  puts "Enter the distance of your trip (miles):"
  dist = gets.chomp.to_f
  
  puts "Enter the miles per gallon (MPG) of your car:"
  mpg = gets.chomp.to_f
  
  puts "Enter the price of gas per gallon ($):"
  gas = gets.chomp.to_f
  
  puts "Enter your driving speed (MPH):"
  speed = gets.chomp.to_f

  if speed > 60
    too_fast_for_mpg = speed - 60
    mpg = mpg - (too_fast_for_mpg * 2)
  end

  how_long = dist / speed
  how_much = gas / mpg * dist

  puts "Your trip will take #{how_long.round(2)} hours and cost $#{how_much.round(2)}."

end

# Ask the user to choose a calculator
puts "Hello! Which of our awesome calculators would you like to use? Select by number:"
puts "1. Basic Calculator"
puts "2. Mortgage Calculator"
puts "3. BMI Calculator"
puts "4. Trip Calculator"
calc_selector = gets.chomp.strip

# Go to the calculator selected
case calc_selector
when "1" then basic_calc
when "2" then mortgage_calc
when "3" then bmi_calc
when "4" then trip_calc
else puts "Y U NO READ GOOD?!"
end
