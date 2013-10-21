class RenameMoviesActorsToActorsMovies < ActiveRecord::Migration
  def change
    rename_table :movies_actors, :actors_movies
  end
end
