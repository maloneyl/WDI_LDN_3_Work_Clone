class IngredientsController < ApplicationController

  def index
    @ingredients = Ingredient.all
  end

  def show
    @ingredient = Ingredient.find params[:id]
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new params[:ingredient] # note: must be an instance now because we're reusing it in the form template to be rendered AND be ".new" instead of ".create" so that we can validate before save
    if @ingredient.save # i.e. this can only be true if validation is passed
      redirect_to @ingredient
    else
      render :new # i.e. validation failed and return to form
    end
  end

  def edit
    @ingredient = Ingredient.find params[:id]
  end

  def update
    ingredient = Ingredient.find params[:id]
    ingredient.update_attributes params[:ingredient]
    redirect_to ingredient
  end

  def destroy
    ingredient = Ingredient.find params[:id]
    ingredient.delete # i.e. no callbacks
    redirect_to ingredients_path
  end

end
