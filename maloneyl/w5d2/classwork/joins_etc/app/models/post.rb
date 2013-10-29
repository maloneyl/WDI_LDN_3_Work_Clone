class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  has_many :tags
  
  attr_accessible :name, :category_id, :published_at
end
