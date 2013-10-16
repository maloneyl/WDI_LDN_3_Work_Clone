class Book < ActiveRecord::Base
  belongs_to :bookshelf
  has_one :bookstore, through: :bookshelf
  has_and_belongs_to_many :authors
end
