class Comment < ActiveRecord::Base
  attr_accessible :text

  belongs_to :post 
end
