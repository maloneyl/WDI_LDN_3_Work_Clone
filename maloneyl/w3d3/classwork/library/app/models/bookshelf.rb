class Bookshelf < ActiveRecord::Base
  has_many :books
  belongs_to :bookstore
end
