class QuantitiesController < ApplicationController

  load_and_authorize_resource :recipe
  load_and_authorize_resource :quantity, :through => :recipe

  def new
    # @recipe = Recipe.find params[:recipe_id]
    # @quantity = Quantity.new
  end

  def create
    # @recipe = Recipe.find(params[:recipe_id])
    quantity = @recipe.quantities.create(params[:quantity])
    redirect_to @recipe
  end

  def destroy
    # @quantity = Quantity.find(params[:id])
    @quantity.delete
    redirect_to(@recipe)
  end

  def move_in_list
    # @recipe = Recipe.find params[:recipe_id]
    # @quantity = @recipe.quantities.find params[:id]
    # our route is /recipes/:recipe_id/quantities/:id/move/:direction(.:format)
    # so we can use :direction as a params
    case params[:direction]
    when 'up'
      @quantity.move_higher
    when 'down'
      @quantity.move_lower
    end
    redirect_to @recipe
  end

end
