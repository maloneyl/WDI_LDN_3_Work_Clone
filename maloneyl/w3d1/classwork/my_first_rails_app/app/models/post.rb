class Post < ActiveRecord::Base # inherited a whole bunch of stuff
  attr_accessible :text, :title

  has_many :comments

  # attr_accessors are set by what Rails sees in the database

  def word_count
    text.split.size
  end

  def comment_count
    comments.count
  end

end
