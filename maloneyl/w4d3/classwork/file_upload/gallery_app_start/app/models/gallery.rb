class Gallery < ActiveRecord::Base
  attr_accessible :address, :name
  has_many :paintings
end
