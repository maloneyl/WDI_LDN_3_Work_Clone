class Quantity < ActiveRecord::Base
  attr_accessible :recipe_id, :ingredient_id, :description, :price, :quantity, :measurement

  belongs_to :recipe
  belongs_to :ingredient

  validates :ingredient_id, presence: true
  validates :recipe_id, presence: true
  validates :quantity, numericality: true
  
end