class Recipe < ActiveRecord::Base
  attr_accessible :name, :course, :cooktime, :servingsize, :instructions, :image

  has_many :quantities, order: 'position ASC' # order by position column, ascending order
  has_many :ingredients, through: :quantities, order: 'position ASC'

  validates :name, presence: true
  validates :cooktime, presence: true

  belongs_to :user

end
