class MainController < ApplicationController

  def index
    @current_movies = CurrentMoviesRatings.get_current_movies
  end

end
