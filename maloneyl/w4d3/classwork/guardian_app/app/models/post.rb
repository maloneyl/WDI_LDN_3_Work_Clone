class Post < ActiveRecord::Base
  belongs_to :author
  attr_accessible :category, :content, :title, :author_id
  belongs_to :author
end
