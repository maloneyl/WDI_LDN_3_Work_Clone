module RecipeHelper
  def cost_in_pounds cost
    "£#{(cost/1.62).round(2)}"
  end


end