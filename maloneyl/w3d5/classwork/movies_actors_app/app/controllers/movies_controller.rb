class MoviesController < ApplicationController

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find params[:id]
  end 

  def new
    @movie = Movie.new
  end

  def create
    movie = Movie.new params[:movie]
    movie.save
    redirect_to movie
  end

  def edit
    @movie = Movie.find params[:id]
    @actors = Actor.all # for that "add an actor" dropdown
  end

  def update  
    movie = Movie.find params[:id]
    # if params[:actor_id] has been passed, that means we want to add an actor
    if params[:actor_id]
      movie.actors << Actor.find(params[:actor_id])
      movie.save
    # otherwise, if there's no actor_id params passed, it's just a regular update
    else 
      movie.update_attributes params[:movie]
    # reminder: update_attributes includes save, so no need to do movie.save here     
    end
    redirect_to movie
  end

  def destroy
    movie = Movie.find params[:id]
    movie.destroy
    redirect_to movies_url
  end

  private

  def which_layout
    if 2 + 2 == 5
      'one_layout'
    else
      'another_layout'
    end
  end

end
