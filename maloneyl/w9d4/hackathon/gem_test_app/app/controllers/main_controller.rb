class MainController < ApplicationController

  def index
    @current_movies = CurrentMovies.get_current_movies
  end

end
