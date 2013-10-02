# Create an app that will randomly assign groups of people in the class
# Take a group size as input and print what groups are
# If the class doesn't divide entirely, any remaining student(s) should be in the last group with a smaller size
# Hint: Use arrays, division, prompt

# Create an array with the names of everyone in the class
wdi = [ "Adam Buchan", 
  "Alex Fasanmade", 
  "Alex Hamlin", 
  "Christos Shionis", 
  "Clemens Kazda", 
  "Daida Medina", 
  "Jack Lalley", 
  "Jamie Wallace", 
  "Jonny Adshead", 
  "Maloney Liu", 
  "Neha Shah", 
  "Oli Peate",
  "Ralph Reid",
  "Rob Forbes", 
  "Selina Chotai",
  "Sharif Zu'bi",
  "Sophie Chitty",
  "Winna Bridgewater"
]


# Prompt the user to give us the group size wanted
puts "Hello! Let's generate some lab groups."
print "How many people should be a group? "
size_wanted = gets.to_i # assumes the user will type in a valid number

# We'll need to have this many groups then
number_of_groups = wdi.length / size_wanted
# e.g. 18 / 4 = 4.5

# Shuffle the class to then distribute into the group size
wdi_randomized = wdi.shuffle
# puts wdi_randomized # just testing


current_group = 1

  puts "Group #{current_group} is:"
  puts "#{someone}"
  number_of_groups.times do |group_number|
    puts "#{wdi_randomized[select_someone]}"
    end

  current_group += 1 until current_group == number_of_groups.to_i

