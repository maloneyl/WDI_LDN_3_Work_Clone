class Quantity < ActiveRecord::Base
  attr_accessible :ingredient_id, :description, :quantity, :measurement, :price
  belongs_to :recipe # think of it as stuff belonging to one recipe, one ingredient
  belongs_to :ingredient

  # validates :ingredient_id, presence: true, on: :update
  validates :ingredient_id, presence: true
  # validates :ingredient_id, presence: true, if: ingredient_exists?
  # validates :ingredient_id, uniqueness: { scope: :recipe_id, case_sensitive: false }, message: "rofl" # by default case_sensitive is true
  # # validates :ingredient_id, uniqueness: { scope: [:recipe_id, :quantity] }  
  validates :recipe_id, presence: true
  validates :quantity, numericality: {greater_than: 0}
  validates :price, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100} 

  # validate :my_own_validator # yes, it's 'validate', not 'validates'

  # def my_own_validator
  #   if Ingredient.count > 0 && self.ingredient_id.present?
  #   # OR: if Ingredient.count > 0 && self.ingredient_id == nil      
  #     errors.add(:ingredient_id, "must have a value") # arguments: field, message (and the error message to display will automatically be strung together)
  #   end  
  # end

  # def ingredient_exists?
  #   Ingredient.count > 0
  # end

end
