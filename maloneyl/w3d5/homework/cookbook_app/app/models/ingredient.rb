class Ingredient < ActiveRecord::Base
  attr_accessible :name, :image
  has_and_belongs_to_many :recipes

end
