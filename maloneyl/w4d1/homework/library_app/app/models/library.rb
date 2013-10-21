class Library < ActiveRecord::Base
  attr_accessible :name, :address
  has_many :bookshelves
  has_many :books, through: :bookshelf
end