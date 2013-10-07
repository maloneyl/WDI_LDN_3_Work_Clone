require 'rainbow'

#get the path to our file
filename = File.dirname(__FILE__) + '/file_parsing/data.csv'

#open a file handle
f = File.open filename
puts "opened file handle for #{filename}"
begin
  puts "doing some (potentially buggy) processing on #{filename}"
  f.readlines.count / 0
rescue => e
  puts "whoopsie: #{e}".color(:red)
else
  puts "file successfully processed".color(:green)
ensure
  f.close #make sure we close the handle no matter what!
  puts "closed file handle for #{filename}".color(:yellow)
end

puts "AWESOME - I didn't crash!"