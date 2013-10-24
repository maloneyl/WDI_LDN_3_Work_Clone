class Author < ActiveRecord::Base
  attr_accessible :bio, :birthdate, :full_name
  has_many :posts
end
