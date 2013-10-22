class User < ActiveRecord::Base
  has_secure_password # understands password and password confirmation even though neither is a field in the db
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  attr_accessible :email, :name, :role, :password, :password_confirmation

end
