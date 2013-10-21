class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.new params[:recipe]
    recipe.save
    redirect_to recipe
  end

  def show
    @recipe = Recipe.find params[:id]
  end

  def edit
    @recipe = Recipe.find params[:id]
    @ingredients = Ingredient.all    
  end

  def update
    recipe = Recipe.find params[:id]
    if params[:ingredient_id]
      recipe.ingredients << Ingredient.find(params[:ingredient_id])
      recipe.save
    else 
      recipe.update_attributes params[:recipe]
    end
    redirect_to recipe
  end

  def destroy
    recipe = Recipe.find params[:id]
    recipe.destroy
    redirect_to recipes_url
  end

end
