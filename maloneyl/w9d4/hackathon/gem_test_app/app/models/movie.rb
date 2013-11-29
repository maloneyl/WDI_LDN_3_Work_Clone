class Movie < ActiveRecord::Base

  attr_accessible :title, :imdb_rating, :rottentomatoes_rating, :average_rating, :poster, :genre, :director, :actors

end
