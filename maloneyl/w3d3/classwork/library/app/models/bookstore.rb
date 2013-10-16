class Bookstore < ActiveRecord::Base
  has_many :bookshelves
  has_many :books, through: :bookshelves
end
