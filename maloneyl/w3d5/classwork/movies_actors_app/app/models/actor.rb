class Actor < ActiveRecord::Base
  attr_accessible :birthdate, :first_name, :last_name
  has_and_belongs_to_many :movies

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
