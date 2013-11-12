class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable and
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable,
         :timeoutable,
         :omniauthable,
         :confirm_within => 10.minutes,
         :omniauth_providers => [:google_oauth2]

  # devise param1, param2, key1 => value1, key2 => value2

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def self.from_omniauth(auth)
    binding.pry # to see what auth contains

    # first, find the user by the email address returned by google
    if user = User.find_by_email(auth.info.email)
      # rails has overwritten ruby's method_missing method and so will deduce the right method from the text and let us use find with email!
      # Hashie is a gem that Devise uses and Hashie::Mash is what allows us to do auth.info.email in addition to h[:info][:email]

      # .provider and .uid are just columns in our user table (need to generate migration if not done already)
      # for a user who's already a gallery app user, update that user's records with these provider and UID fields too because now we have them
      user.provider = auth.provider
      user.uid = auth.uid
      user

    # if the user is not already in our gallery app db, create this user based on this user's google account info
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user| # if we don't slice, auth is a giant hash of google account details (including G+ link, profile, gender); uid = universal identifier
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20] # generate a password for that user (because obviously we can't just grab their google password)
        user.skip_confirmation! # change corresponding column in our db as if the user has confirmed their email already so that devise doesn't send a confirm-your-email email (which they have, because they're signing in with google, i.e. has a gmail)
        user
      end
    end

  end

end
