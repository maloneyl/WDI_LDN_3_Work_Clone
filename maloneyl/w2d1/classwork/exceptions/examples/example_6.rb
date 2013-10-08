print "what ruby code should I eval? "
code = gets.chomp

#we can rescue specific error types like this
begin
  puts "running your code gives: #{eval code}"
rescue ZeroDivisionError
  puts "dividing by zero is pretty dumb!"
rescue NameError, NoMethodError
  puts "mentioning unknown variables or methods is a no-no!"
end

puts "AWESOME - I didn't crash!"