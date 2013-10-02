# Ask user for the "from" and the "to" and store them
# Calculate the distance in terms of the number of stops

# As all lines intersect at Union Square, distance between anything cross-lines should be
# number of stops from Union Sq on its own line + number of stops from Union Sq on the other line

# If to-from are on the same line, then the distance is just their index differences

# For section readability
require 'rainbow'

# Our 3 lines
line_n = [ "Times Square", "34th", "28th", "23rd", "Union Square", "8th" ]
line_l = [ "8th", "6th", "Union Square", "3rd", "1st" ]
line_6 = [ "Grand Central", "33rd", "28th", "23rd", "Union Square", "Astor Place" ]

puts "***** JOURNEY PLANNER *****"

# Ask and store user input re: origin
puts "\nI'M STARTING AT...".color(:blue)
puts "\nLINE: Enter N, L or 6"
from_line = gets.chomp.strip
puts "\nSTATION: Enter by number below"
case from_line 
when "n", "N"
  line_n.each_with_index { |station, index| puts "#{index+1}. #{station}" } # +1 because starting from 0 is weird to normal people
  origin_line_to_use = line_n
when "l", "L"
  line_l.each_with_index { |station, index| puts "#{index+1}. #{station}" } 
  origin_line_to_use = line_l
when "6"
  line_6.each_with_index { |station, index| puts "#{index+1}. #{station}" } 
  origin_line_to_use = line_6
end
from_stop = gets.chomp.to_i

# Ask and store user input re: destination
puts "\nI'M GOING TO...".color(:magenta)
puts "\nLINE: Enter N, L or 6"
to_line = gets.chomp.strip
puts "\nSTATION: Enter by number below"
case to_line 
when "n", "N"
  line_n.each_with_index { |station, index| puts "#{index+1}. #{station}" }
  destination_line_to_use = line_n
when "l", "L"
  line_l.each_with_index { |station, index| puts "#{index+1}. #{station}" } 
  destination_line_to_use = line_l
when "6"
  line_6.each_with_index { |station, index| puts "#{index+1}. #{station}" } 
  destination_line_to_use = line_6
end
to_stop = gets.chomp.to_i

# If to-from are on the same line, the distance is just the index difference in the array, made absolute
if origin_line_to_use == destination_line_to_use
   distance = (from_stop - to_stop).abs
   if distance > 1
    puts "\nDISTANCE: #{distance} stops".color(:green)
   else 
    puts "\nDISTANCE: #{distance} stop".color(:green)
   end
# If to-from are on different lines, count the number of stops between 'from' and Union Square
# as well as the number of stops between 'to' and Union Square
else
  origin_dist_from_u_sq = (from_stop-1) - origin_line_to_use.index("Union Square")
  # puts from_dist_from_u_sq # just testing
  destination_dist_from_u_sq = (to_stop-1) - destination_line_to_use.index("Union Square")
  # puts to_dist_from_u_sq # just testing
  distance = origin_dist_from_u_sq.abs + destination_dist_from_u_sq.abs
  if distance > 1
    puts "\nDISTANCE: #{distance} stops".color(:green)
  else 
    puts "\nDISTANCE: #{distance} stop".color(:green)
  end
end

