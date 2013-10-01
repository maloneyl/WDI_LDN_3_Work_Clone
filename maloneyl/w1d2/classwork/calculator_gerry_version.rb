def compute operation, a, b
  result = case operation
  when 'a'
    "#{a + b}"
  when 's'
    "#{a - b}"
  when 'm'
    "#{a * b}"
  when 'd'
    "#{a / b}"
  end
  puts result
end
 
def basic_calc
  print "(a)dd, (s)ubtract, (m)ultiply, (d)ivide: "
  operation = gets.chomp.downcase
  print "first number: "
  a = gets.to_f
  print "second number: "
  b = gets.to_f
  compute(operation, a, b)
  gets
end
basic_calc