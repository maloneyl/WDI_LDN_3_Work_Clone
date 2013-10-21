class Recipe < ActiveRecord::Base
  attr_accessible :name, :course, :cooktime, :serving_size, :instructions, :image
  has_many :quantities
  has_many :ingredients, through: :quantities
end