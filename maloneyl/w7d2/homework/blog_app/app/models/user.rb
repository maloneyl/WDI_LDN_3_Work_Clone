class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable, :confirmable, :omniauthable,
         :confirm_within => 10.minutes,
         :omniauth_providers => [:google_oauth2]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :posts # , dependent: :destroy
  has_many :comments # , dependent: :destroy

  def self.from_omniauth(auth)
    # first, find the user by the email address returned by google
    if user = User.find_by_email(auth.info.email) # rails has overwritten ruby's method_missing method and so will deduce the right method from the text and let us use find with email!
      # .provider and .uid are just columns in our user table
      user.provider = auth.provider
      user.uid = auth.uid
      user

    # if the user is not already in the db, create this user based on this user's google account info
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user| # we don't slice, auth is a giant hash; uid = universal identifier
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.name = auth.info.name # because our app wants a name too...
        user.password = Devise.friendly_token[0,20] # generate a password for that user (because obviously we can't just grab their google password)
        user.skip_confirmation! # change corresponding column in our db as if the user has confirmed their email already so that devise doesn't send a confirm-your-email email (which they have, because they're trying to sign in with google...)
        user
      end
    end
  end

  def role?(r)
    self.role == r.to_s # because db field is always a string; while r could be passed in either symbol or string
  end

end
