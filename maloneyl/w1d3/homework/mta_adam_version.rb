#Assign tube routes to arrays
#Prompt user for inputs
#Check inputs for errors
#Determine if route is on same line
#If same line calculate tube stops
#If different line:
#Calculate stops to Union Square on Line 1
#Calculate stops to destination on Line 2
#Calculate total tube stops

n_line = ["times square", "34th", "28th", "23rd", "union square", "8th"]
l_line = ["8th", "6th", "union square", "3rd", "1st"]
six_line = ["grand central", "33rd", "28th", "23rd", "union square", "astor place"]

puts "Please enter the station you are travelling from:"
origin_station = gets.chomp.downcase
puts "Please enter the line this is on"
puts "Choose from n, l or six:"
origin_line = gets.chomp.downcase
puts "Please enter the station you are travelling to:"
destination_station = gets.chomp.downcase
puts "Please enter the line this is on"
puts "Choose from n, l or six:"
destination_line = gets.chomp.downcase

case org_line
  when "n"
    sta_line = n_line
  when "l"
    sta_line = l_line
  when "six"
    sta_line = six_line
  else
    puts "You have entered an invalid line"
    exit
end

def exit_program
  puts "You have entered an invalid station of origin"
  exit
end

case org_line
  when "n"
    unless n_line.include?(org_station) 
      puts "You have entered an invalid station of origin"
      exit
    end
  when "l"
    if l_line.include?(org_station)
    else
      puts "You have entered an invalid station of origin"
      exit
    end
  when "six"
    if six_line.include?(org_station)
    else
      puts "You have entered an invalid station of origin"
      exit
    end
end


# This is Gerry's more concise version of the above:
# case org_line
#  when "n" then exit_program unless n_line.include?(org_station) 
#  when "l" then exit_program unless n_line.include?(org_station) 
#  when "six" then exit_program unless n_line.include?(org_station) 
# end

case des_line
  when "n"
    sto_line = n_line
  when "l"
    sto_line = l_line
  when "six"
    sto_line = six_line
  else
    puts "You have entered an invalid line"
    exit
end

case des_line
  when "n"
    if n_line.include?(des_station) 
    else
      puts "You have entered an invalid destination station"
      exit
    end
  when "l"
    if l_line.include?(des_station)
    else
      puts "You have entered an invalid destination station"
      exit
    end
  when "six"
    if six_line.include?(des_station)
    else
      puts "You have entered an invalid destination station"
      exit
    end
end

def same_line(start, stop, line)
  a = line.index(stop)
  b = line.index(start)
  stops = (a-b).abs
  puts ""
  puts "The number of stops you will need to travel is #{stops}"
end

def diff_line(start, stop, line1, line2)
  a = line1.index(start)
  b = line1.index("union square")
  stops1 = (a-b).abs
  c = line2.index(stop)
  d = line2.index("union square")
  stops2 = (c-d).abs
  stops = stops1 + stops2
  puts ""
  puts "The number of stops you will need to travel is #{stops}"
end  

if org_line == des_line
  same_line(org_station, des_station, sta_line)
else
  diff_line(org_station, des_station, sta_line, sto_line)
end