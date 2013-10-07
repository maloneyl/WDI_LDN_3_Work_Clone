file = File.new("./database.txt", "r") # Ruby will create a file named that if it doesn't exist yet
file.each do |line|
  puts line.chomp.split(", ")
  puts "______________"
end

# print "Add info for a new person (name, age, sex) "
# file.puts gets.chomp
file.close # you must do this!