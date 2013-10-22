class Book < ActiveRecord::Base
  attr_accessible :title, :author, :pages, :year, :cover
  belongs_to :bookshelf
  has_one :library, through: :bookshelf

  validates :title, presence: true
  validates :author, presence: true, uniqueness: true
  validates :pages, numericality: { only_integer: true }
  validates :year, numericality: { only_integer: true }
end