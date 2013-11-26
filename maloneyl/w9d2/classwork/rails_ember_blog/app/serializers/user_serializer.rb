class UserSerializer < ActiveModel::Serializer

  # specify what we want to send
  attributes :id, :email, :name

  # no need to put has_many :posts here because we don't need this user JSON to include posts stuff, but we do want that the other way around

end
