class Quantity < ActiveRecord::Base
  attr_accessible :ingredient_id, :description, :quantity, :measurement, :price
  belongs_to :recipe
  belongs_to :ingredient


  def my_own_validator
    if Ingredient.count> 0 && self.ingredient_id.present?
      errors.add(:ingredient_id, "must have a value")
    end
  end

end