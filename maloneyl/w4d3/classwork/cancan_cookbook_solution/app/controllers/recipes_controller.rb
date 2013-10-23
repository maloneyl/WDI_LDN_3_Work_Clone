class RecipesController < ApplicationController

  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created!'
    else
      flash.now[:alert] = 'Recipe was NOT created!'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @recipe.update_attributes(params[:recipe])
      redirect_to @recipe, notice: 'Recipe was successfully updated!'
    else
      flash.now[:alert] = 'Recipe was NOT updated!'
      render :edit
    end
  end

  def destroy
    @recipe.delete
    redirect_to recipes_path
  end

  def flag
    @recipe.flagged = true
    @recipe.save
    flash[:notice] = 'Recipe was flagged!'
    render :show
  end

  def flagged
    @recipes = Recipe.where(:flagged => true).all
    render :index
  end

end
