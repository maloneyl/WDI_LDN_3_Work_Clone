class Movie < ActiveRecord::Base
  attr_accessible :title, :release_date, :poster, :director, :rating
  has_and_belongs_to_many :actors
end
