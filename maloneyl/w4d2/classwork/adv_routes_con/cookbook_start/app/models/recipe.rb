class Recipe < ActiveRecord::Base
  attr_accessible :name, :course, :cooktime, :servingsize, :instructions, :image

  has_many :quantities
  has_many :ingredients, through: :quantities
  belongs_to :user
  
  validates :name, presence: true
  validates :cooktime, presence: true
  
end
