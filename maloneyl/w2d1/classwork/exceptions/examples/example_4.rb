require "rainbow"

print "what shall I divide 100 by? "
num = gets.to_i

begin
  puts "the result of 100 divided by #{num} is #{100/num}"
rescue => e
  puts "whoopsie: #{e}".color(:red)
else
  puts "this 'else' clause is called ONLY if no exception is raised".color(:green)
ensure
  puts "this 'ensure' clause is called no matter what happens".color(:yellow)
end

puts "AWESOME - I didn't crash!"