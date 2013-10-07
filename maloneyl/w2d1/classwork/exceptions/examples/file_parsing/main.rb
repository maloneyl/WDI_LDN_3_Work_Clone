require 'pry'
require 'pry-byebug'
require 'rainbow'

require_relative "lib/simple_csv"

def prompt
  print "please enter a (relative) path to a CSV file, or enter 'q' to quit: "
  gets.strip.chomp
end

puts `clear`
input = prompt

while input != "q"
  
  filename = File.dirname(__FILE__) + '/' + input
  reader = SimpleCsv::Reader.new filename, true
  
  begin
    reader.parse_file
  rescue SimpleCsv::FileMissingError
    puts "sorry, that file doesn't exist".color(:red)
  rescue SimpleCsv::FormatError => e
    puts "WARNING: some data ignored due to a formatting error: #{e}\n\n".color(:yellow)
    puts reader.data
  rescue
    puts "sorry, something went wrong while trying to parse the file".color(:red)
  else
    puts "file parsed successfully:\n\n".color(:green)
    puts reader.data
  end
  
  puts "\n--------------------------------------------------------------------------------\n\n"
  
  input = prompt
  
end