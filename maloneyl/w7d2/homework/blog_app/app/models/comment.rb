class Comment < ActiveRecord::Base
  attr_accessible :body

  belongs_to :post
  belongs_to :user
end
