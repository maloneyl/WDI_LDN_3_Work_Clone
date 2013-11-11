class Painting < ActiveRecord::Base
  attr_accessible :artist, :description, :gallery_id, :image, :price, :title, :remote_image_url
  belongs_to :gallery
  mount_uploader :image, ImageUploader

private

  def self.reprocess_all!
    all.each do |painting|
      painting.image.recreate_versions!
    end
  end

end
