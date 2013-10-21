class Bookshelf < ActiveRecord::Base
  attr_accessible :category
  belongs_to :library
  has_many :books

  validates :category, presence: true
end