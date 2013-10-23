class Recipe < ActiveRecord::Base
  attr_accessible :name, :course, :cooktime, :servingsize, :instructions, :image

  has_many :quantities
  has_many :ingredients, through: :quantities

  validates :name, presence: true
  validates :cooktime, presence: true

  belongs_to :user

  mount_uploader :image, ImageUploader

end
