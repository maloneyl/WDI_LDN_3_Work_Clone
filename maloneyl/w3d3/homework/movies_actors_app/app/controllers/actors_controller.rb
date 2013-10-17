class ActorsController < ApplicationController

  def index
    @actors = Actor.all
  end

  def show
    @actor = Actor.find params[:id]
  end 

  def new
    @actor = Actor.new
  end

  def create
    actor = Actor.new params[:actor]
    actor.save
    redirect_to actor
  end

  def edit
    @actor = Actor.find params[:id]
    @movies = Movie.all
  end

  def update  
    actor = Actor.find params[:id]
    # if the second form (actor) is submitted, push that movie into the actor.movies array
    if params[:movie_id]
      actor.movies << Movie.find(params[:movie_id])
      actor.save
      # movie = Movie.find(params[:movie_id]) -- this is just saving the other way around
      # movie.actors << actor -- (cont'd above)
    else 
      actor.update_attributes params[:actor]
      # update_attributes includes save already, so we don't need to to actor.save here
    end
    redirect_to actor
  end

  def destroy
    actor = Actor.find params[:id]
    actor.destroy
    redirect_to actors_url
  end

end
