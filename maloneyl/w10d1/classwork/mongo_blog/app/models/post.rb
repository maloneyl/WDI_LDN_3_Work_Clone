class Post
  include MongoMapper::Document

  key :title, String # typecast is not required
  key :content, String # typecast is not required
  key :view_count, Integer

  timestamps! # no timestamps by default; need to put this in manually

  belongs_to :user
  has_many :comments # treat embedded docs as if they're associations

  def self.flagged
    where(flagged: true)
  end

end
