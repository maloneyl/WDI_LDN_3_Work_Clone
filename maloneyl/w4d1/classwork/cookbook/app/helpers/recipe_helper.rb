module RecipeHelper # yes, singular
  def cost_in_pounds cost
    "£#{(cost/1.62).round(2)}"
  end

  def formatted_quantity quantity
    "#{quantity.quantity} #{quantity.measurement}"
  end 
end
