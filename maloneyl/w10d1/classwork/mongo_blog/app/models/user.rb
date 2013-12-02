class User
  include MongoMapper::Document

  key :name, String
  key :age, Integer

  timestamps!

  has_many :posts

  validates_presence_of :name
  validates_numericality_of :age

end
