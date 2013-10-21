class QuantitiesController < ApplicationController

  def new
    @recipe = Recipe.find params[:recipe_id]
    @quantity = @recipe.quantities.new # referencing: /recipes/:recipe_id/quantities
  end

  def create
    @recipe = Recipe.find params[:recipe_id]
    @quantity = @recipe.quantities.new params[:quantity]
    if @quantity.save
      redirect_to @recipe
    else
      render :new
    end
  end

end