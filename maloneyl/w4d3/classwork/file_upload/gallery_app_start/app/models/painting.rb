class Painting < ActiveRecord::Base
  attr_accessible :artist, :description, :gallery_id, :price, :title, :image
  belongs_to :gallery

  mount_uploader :image, ImageUploader

end
