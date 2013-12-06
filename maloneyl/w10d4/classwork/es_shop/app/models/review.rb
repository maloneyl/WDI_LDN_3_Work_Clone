class Review
  include MongoMapper::EmbeddedDocument # to be embedded in Product

  key :title, String
  key :content, String
  key :rating, Integer
  timestamps!

end
