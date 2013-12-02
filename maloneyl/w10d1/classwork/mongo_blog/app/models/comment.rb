class Comment
  include MongoMapper::EmbeddedDocument # because we're embedding comments in posts

  key :content, String

  timestamps!

  belongs_to :user

end
