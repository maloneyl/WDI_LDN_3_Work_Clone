class Post < ActiveRecord::Base
  attr_accessible :content, :title

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { minimum: 5 }
end
