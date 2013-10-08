require "pry"
require "rainbow"

class WordArray

  include Enumerable

  def initialize(string)
    @words = string.split # split on whitespace, default split behavior
    @word_count = @words.length
  end

  def each # define your own each method with a yield so that the user can do something else
    for i in 0...@word_count
      yield(@words[i], i) 
    end
  end

end

words = WordArray.new "foo bar baz wibble wobble"

words.each do |word, i|
  puts "word #{i} is #{word}"
end

binding.pry