class RecipesController < ApplicationController

  load_and_authorize_resource except: [:index, :flagged]


  # List all available recipes
  #
  # GET `/recipes`
  #
  # @return [HTML] 200
  def index
    page = params[:page] || 1
    per_page = 5
    # @recipes = Recipe.offset((page-1)*per_page).limit(per_page).order(:created_at)
    @recipes = Recipe.paginate(page: page, per_page: per_page).order('created_at')
    authorize! :read, @recipes
  end

  def new
  end


  # Create an recipe
  #
  # POST `/recipes`
  #
  # Example
  #
  # curl -X POST http://localhost:300/recipes
  #
  # @param [Hash] recipe: The hash containing the data for the new recipe
  #
  # @return [HTML] 301: redirect to the show page for the created recipe
  #
  # @return [HTML] 401: unthorized access to the method
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
    page = params[:page] || 1
    per_page = 5
    @recipes = Recipe.paginate(page: page, per_page: per_page).where(:flagged => true).order('created_at').all
    authorize! :read, @recipes
    render :index
  end

end
