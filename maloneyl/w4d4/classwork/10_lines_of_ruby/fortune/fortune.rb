user_input = ''
while user_input != 'quit'
  puts "Say anything other than 'quit' to get your Very Accurate Fortune!"
  user_input = gets.chomp
  chosen_line = File.readlines("data.txt").sample
  puts ("\n" + chosen_line + "\n") unless user_input == 'quit'
end