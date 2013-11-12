class Gallery < ActiveRecord::Base
  attr_accessible :address, :name, :paintings_attributes
  has_many :paintings, :dependent => :destroy
  accepts_nested_attributes_for :paintings, :reject_if => lambda { |painting| painting[:title].blank? }, :allow_destroy => true
end
