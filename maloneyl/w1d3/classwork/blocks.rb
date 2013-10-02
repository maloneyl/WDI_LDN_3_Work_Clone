# what we're doing: push to an array the multiples of 3 in the range of 0-10

# version 1
valid = []
(0..10).to_a.each do |value|
  if value % 3 == 0
    valid.push value
  end
end
valid

# version 2
valid = []
(0..10).to_a.each do |value|
  valid.push(value) if value % 3 == 0
end

# version 3
valid = (0..10).to_a.select do |value|
  value % 3 == 0
end

# version 4 -- down to just one line!
valid = (0..10).to_a.select { |value| value % 3 == 0 }


# now let's multiply something

# version 1
multiplied = []
(0..10).to_a.each do |value|
  new_value = value * 3 
  multiplied.push new_value
end
multiplied

# version 2
multiplied = (0..10).to_a.collect { |value| value * 3 }
# or the below: collect and map are the same
multiplied = (0..10).to_a.map { |value| value * 3 }



# some hashes

instructors = {
  instructor1: "Gerry",
  instructor2: "Jon",
  instructor3: "David",
  instructor4: "Julien"
}

# try 1
instructors.each do |value|
  puts value.inspect
end

# try 2
instructors.each do |key, value|
  puts "the key of #{value} is #{key}"
end

# try 3
instructors.each_with_index do |value, index|
  puts "the index of #{value} is #{index}"
end

(1..10).to_a.detect { |value| value % 3 == 0 } # detect will see if the block is true and stop if true