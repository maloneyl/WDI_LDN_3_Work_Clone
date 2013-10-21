class Ingredient < ActiveRecord::Base
  attr_accessible :name, :image
  has_many :quantities
  has_many :recipes , through: :quantities

  validates :name, presence: true, uniqueness: true
  validates :image, presence: true
end