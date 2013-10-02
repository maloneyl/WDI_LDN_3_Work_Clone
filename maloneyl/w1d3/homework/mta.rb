# Ask user for the "from" and the "to" and store them
# Calculate the distance in terms of the number of stops

# As all lines intersect at Union Square, distance between anything cross-lines should be
# number of stops from Union Sq on its own line + number of stops from Union Sq on the other line

# Guess we can calculate distances between the same line by getting the stop through index, to_i, then subtract


line_n = [ "Times Square", "34th", "28th", "23rd", "Union Square", "8th" ]
line_l = [ "8th", "6th", "Union Square", "3rd", "1st" ]
line_6 = [ "Grand Central", "33rd", "28th", "23rd", "Union Square", "Astor Place" ]

puts "FROM:"
puts "Line: N, L or 6"
from_line = gets.chomp

case from_line
when "n", "N"
  puts "Stop: Times Square, 34th, 28th, 23rd, Union Square, 8th"
  from_line_base = line_n
when "l", "L"
  puts "Stop: 8th, 6th, Union Square, 3rd, 1st"
  from_line_base = line_l
when "6"
  puts "Stop: Grand Central, 33rd, 28th, 23rd, Union Square, Astor Place"
  from_line_base = line_6
end

from_stop = gets.chomp 

puts "TO:"
puts "Line: N, L or 6"
to_line = gets.chomp

case to_line
when "n", "N"
  puts "Stop: Times Square, 34th, 28th, 23rd, Union Square, 8th"
  to_line_base = line_n
when "l", "L"
  puts "Stop: 8th, 6th, Union Square, 3rd, 1st"
  to_line_base = line_l  
when "6"
  puts "Stop: Grand Central, 33rd, 28th, 23rd, Union Square, Astor Place"
  to_line_base = line_6
end

to_stop = gets.chomp 

# If to-from are on the same line, the distance is just the index difference in the array.
if from_line == to_line
   distance = from_line_base.index(from_stop) - to_line_base.index(to_stop)
   puts "DISTANCE: #{distance.abs} stops"
# If it is not, count the number of stops between from_stop and Union Square
# as well as the number of stops between the to_stop from Union Square
else
  from_dist_from_u_sq = from_line_base.index(from_stop) - from_line_base.index("Union Square")
  # puts from_dist_from_u_sq # just testing
  to_dist_from_u_sq = to_line_base.index(to_stop) - to_line_base.index("Union Square")
  # puts to_dist_from_u_sq # just testing
  distance = from_dist_from_u_sq.abs + to_dist_from_u_sq.abs
  puts "DISTANCE: #{distance} stops"
end

