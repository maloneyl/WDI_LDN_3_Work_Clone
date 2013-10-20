class Recipe < ActiveRecord::Base
  attr_accessible :content, :name, :image
  has_and_belongs_to_many :ingredients
end
