class RecipesController < ApplicationController

  before_filter :find_record, only: [:show, :edit, :update, :destroy, :flag]

  # before_filter :authenticate, :except => [:index, :show]

  # after_filter :log_something, :only => [:index, :flagged]

  # around_filter :trap_something

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect_to @recipe, notice: 'Recipe was successfully created!'
    else
      flash[:alert] = 'Recipe was NOT created!'
      render :new
    end
  end

  def show
    #@recipe = Recipe.find(params[:id])
  end

  def edit
    #@recipe = Recipe.find(params[:id])
  end

  def update
    #@recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to @recipe, notice: 'Recipe was successfully updated!'
    else
      flash[:alert] = 'Recipe was NOT updated!'
      render :edit
    end
  end

  def destroy
    #@recipe = Recipe.find(params[:id])
    @recipe.delete
    redirect_to recipes_path
  end

  def flag
    #@recipe = Recipe.find(params[:id])
    @recipe.flagged = true
    @recipe.save
    flash[:notice] = 'Recipe was flagged!'
    render :show
  end

  def flagged
    @recipes = Recipe.where(:flagged => true).all
    render :index
  end

private

  def find_record
    @recipe = Recipe.find(params[:id])
  end

  def log_something
    logger.info "\n\n#{@recipes.count} recipes fetched from DB\n\n"
  end

  def trap_something
    #do something before the action
    logger.info "\n\nABOUT TO PERFORM ACTION\n\n"
    begin
      yield #to the action
    rescue => e
      #perform a daring rescue
    ensure
      #ensure something happens
      logger.info "\n\nFINISHED ACTION\n\n"
    end
  end

end