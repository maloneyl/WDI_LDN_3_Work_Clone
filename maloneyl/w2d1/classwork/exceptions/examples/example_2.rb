puts "about to do something stupid..."

begin
  puts "the result of 100 divided by 0 is #{100/0}"
rescue
  puts "whoopsie"
end

puts "AWESOME - I didn't crash!"