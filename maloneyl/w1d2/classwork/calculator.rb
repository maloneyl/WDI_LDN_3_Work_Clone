# Write a function for the four operations
def calc(op, a, b)

  case op
  when "a"
    puts "#{a} + #{b} = #{a + b}"
  when "s"
    puts "#{a} - #{b} = #{a - b}"
  when "m"
    puts "#{a} * #{b} = #{a * b}"
  when "d"
    puts "#{a} / #{b} = #{a / b}"
  end

end

# Show an invite to the user
puts "Hello! Which operation would you like to do?"
puts "(a)dd, (s)ubtract, (m)ultiply or (d)ivide"

# Ask the user for the operation and store the value
operation = gets.chomp.strip.downcase # .strip.downcase in case the user types the whole word and/or in caps

# Ask the user for the first number and store the value
puts "First number:"
first_number = gets.chomp.to_i # 'gets' is a string

# Ask the user for the second number and store the value
puts "Second number:"
second_number = gets.chomp.to_i # 'gets' is a string

# Pass the values to a function
calc(operation, first_number, second_number)
puts "w00t!"

# Gerry's version is at https://gist.github.com/geraudmathe/6780452