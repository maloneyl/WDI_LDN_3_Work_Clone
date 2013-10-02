require 'rainbow'
require 'pry'
require 'pry-byebug'
 
# CALCULATIONS
 
def add(x, y)
  print_description "Adding #{x} to #{y} gives: "
  x + y
end
 
def subtract(x, y)
  print_description "Subtracting #{y} from #{x} gives: "
  x - y
end
 
def multiply(x, y)
  print_description "Multiplying #{x} by #{y} gives: "
  x * y
end
 
def divide(x, y)
  print_description "Dividing #{x} by #{y} gives: "
  x / y
end
 
def power(x, y)
  print_description "#{x} raised to the power of #{y} is: "
  x ** y
end
 
def square_root(x)
  print_description "The square root of #{x} is: "
  Math.sqrt(x)
end
 
# UTILITIES
 
def get_number
  input = gets.chomp!
  output = input.to_f
  unless contains_number input
    puts "WARNING: #{input} isn't a valid number, treating as #{output}".color(:red)
  end
  output
end
 
def contains_number(str)
  contains_integer(str) || contains_float(str)
end
 
def contains_float(str)
  str.to_f.to_s == str
end
 
def contains_integer(str)
  str.to_i.to_s == str
end
 
def print_description(str)
  print str.color(:yellow)
end
 
def print_result(num)
  print num.to_s.color(:red)
end
 
# MENUS
 
def menu
  puts `clear`
  puts "***CalcIt***".color("#cc0033")
  print "(b)asic, (a)dvanced, or (q)uit: ".color("#00cc33")
  gets.chomp
end
 
def basic_calc
  print "(a)dd, (s)ubtract, (m)ultiply, (d)ivide: "
  operation = gets.chomp
  print "first number: "
  a = get_number
  print "second number: "
  b = get_number
 
  result = case operation
  when 'a'
    add a, b
  when 's'
    subtract a, b
  when 'm'
    multiply a, b
  when 'd'
    divide a, b
  end
 
  print_result result
 
  gets
end
 
def advanced_calc
  print "(p)ower, (s)qrt: "
  operation = gets.chomp
  print "first number: "
  a = get_number
 
  result = case operation
  when 'p'
    print "second number: "
    b = get_number
    power a, b
  when 's'
    square_root a
  end
 
  print_result result
 
  gets
end
 
# MAIN LOOP
 
response = menu
 
while response != 'q'
  case response
  when 'b'
    basic_calc
  when 'a'
    advanced_calc
  end
 
  response = menu
end