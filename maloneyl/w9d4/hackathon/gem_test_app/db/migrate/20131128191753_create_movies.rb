class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.decimal :imdb_rating
      t.decimal :rottentomatoes_rating
      t.decimal :average_rating
      t.text :poster
      t.string :genre
      t.string :director
      t.string :actors
    end
  end
end
