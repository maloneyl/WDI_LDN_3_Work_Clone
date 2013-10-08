require 'pry'

puts "about to do something stupid..."

begin
  puts "the result of 100 divided by 0 is #{100/0}"
rescue => e # pass the error object
  binding.pry
  puts "whoopsie: #{e}"
  puts "backtrace was:"
  puts e.backtrace.join("\n")
end

puts "AWESOME - I didn't crash!"