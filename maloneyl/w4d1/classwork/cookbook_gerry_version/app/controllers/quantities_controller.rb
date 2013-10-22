class QuantitiesController < ApplicationController
  def new
    @recipe = Recipe.find params[:recipe_id]
    @quantity = @recipe.quantities.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @quantity = @recipe.quantities.new params[:quantity]
    if @quantity.save
      redirect_to @recipe
    else
      render :new
    end
  end
end