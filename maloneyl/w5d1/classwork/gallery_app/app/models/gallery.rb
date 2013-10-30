class Gallery < ActiveRecord::Base
  attr_accessible :address, :name
  has_many :paintings
  validates_presence_of :name
end
