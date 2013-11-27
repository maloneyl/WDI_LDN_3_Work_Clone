class QuantitiesController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
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

end
