QUESTIONS & COMMENTS AFTER HOMEWORK
====================================

* Scaffolding is actually quite confusing...
* For a while I wasn't sure if I was supposed to build an Admin model with devise or just use cancan.
* Would've loved to get to the bonus features, but didn't have enough time!



HOMEWORK
---------

Blog App with Devise, oAuth and CanCan


We start project 2 this Thursday and so we need to get back into the habit of creating a rails app from scratch. So, for tonight's homework you're going to create a new blog app...

Required Specification:
  • Should use postgresql
  • Should use haml/scss
  • Has multiple users
  • Each user should have a name and email address
  • Users can signup/login by either:
  • registering with email + password (app must confirm user owns the email address)
  • or using 3rd party authentication via a popular provider (e.g. Google, Facebook etc.)
  • Each user can create a post or a comment
  • Each post can have many comments
  • Posts and comments should display the name of the user that created them
  • Therefore, a user must be logged in to create or edit posts or comments
  • A user should only be able to edit a post or commment if
  • they created it
  • or they are an admin

Hints:
  • You can use rails g scaffold to create models, controllers and views quickly
  • don't forget to add haml-rails before running any generators (otherwise erb views will be generated)
  • remember that my_first_rails_app (week 3, day 1) was a blog...

Bonus Features:
  • support multiple oAuth providers (i.e. I can associate more than one oAuth provider with my account)
  • add support for displaying the user's "gravatar" alongside their posts and comments
  • if the user's email has no associated gravatar, display an "identicon" instead
  • hint: there's a gem for that...
  • add some basic styling to the site

CLASS NOTES
============

1. AJAX
-------------

classwork: rake_task_app

we'll add a rates_controller.rb and associated views folder with an empty index.html.haml.
rates_controller.rb:
``````
class RatesController < ApplicationController

  respond_to :html, :json # i.e. can render html or json
  # when we go to /rates, /rates.html is the default
  # if you use rails generate to generate a model, these format options are included in our methods

  def index
    rates = Rate.all # won't use it in the template, so doesn't need to be @rates
    respond_with rates # i.e. also respond_to :html, :json
  end

end
``````

routes:
  resources :rates, only: [:index]

now if we go to /rates.json, we'll see a lot of stuff

and in views/rates/index.html.haml, we'll simply have:
	%ul#rates_list

and we'll create a script.js under app/assets/javascript:
````````````````
$(function(){

  // each time this function is called, the data gets refresh even when the page itself doesn't
  function call_api(){
    $.getJSON("/rates.json", function(data){ //returns an array of those objects
      console.log(data);
      $.each(data, function(index, rate){ //index is the loop index
        $("#rates_list").append("<li>" + rate.date_value + " -- " + rate.usd + "</li>");
      })
    })
  }

  call_api();

})
``````````````
which will now give us a list of all 1006 data objects, one line each

now let's make it all cool with chart.js (chartjs.org)
minimum version here: https://raw.github.com/nnnick/Chart.js/master/Chart.min.js
and save it in app/assets/javascripts/chart.js
and when we use rails, we don't need to manually add that script tag!
just need to reload our page for it to automagically come with chart.js already

IMPORTANT: when we use underscore.js, always get rid of that last line:
	//# sourceMappingURL=underscore-min.map
because that line happens to read like a manifest line in rails (ref: application.js), rails is trying to load it even if it's meant to be a comment only…

1b. LAB
--------------------
uk_gdp_app

1. create rails app
2. scaffold (find out what to do before we scaffold if we want to use haml)
3. json call
4. rake tasks
5. chart rendering
6. select data by range



2. DEVISE: OAUTH WITH OMNIAUTHABLE
--------------------------------------------------------------

e.g. sign in using google, twitter, Facebook so people don't have to create another account, give out their email address to another site, etc.

devise has the omniauthable module for oAuth

oAuth (openAuth)
open standard for authorization
lets a user authorize app A to use their info from app B, WITHOUT giving app A their app B password
provider: app B (e.g. fb, twitter, google)
consumer: app A (e.g. our gallery app)

oAuth evolved from work at twitter and other SC startups
2 standards currently in use:
- 1.0 published 2010
- 2.0 published 2012, slowly replacing 1.0 but not backward compatible with 1.0

how it works:
- register with provide and get client id and secret key store those in our app
- user tries to sign in using google
- app sends google the client id, redirect url (i.e. where google should send our user back to), scope (optional; e.g. only read-only access, only create tweets but not do stuff, etc.)
- google send us an auth_token which grants us a session to access that info for some set amount of time
- app uses auth_token to request access_token (sends auth_token and redirect_url to google)
- google checks that they're right, then sends our app that access_token
- app creates connected with google and makes any subsequent google api requests using access_token (sends that access_token to google)
- google validates access_token and services API requests if within authorized scope

*****

gem 'omniauth-google-oauth2'


in config/initializers/devise.rb:
  config.omniauth :google_oauth2, "954197363846.apps.googleusercontent.com", "HFZsKXhR3sFO_5-xS7NAW1C-" # client id and client secret

➜  gallery_app_omniauth_start git:(w7d2-maloneyl) ✗ rake routes
 user_omniauth_authorize GET|POST /users/auth/:provider(.:format)                     devise/omniauth_callbacks#passthru {:provider=>/google_oauth2/}
  user_omniauth_callback GET|POST /users/auth/:action/callback(.:format)              devise/omniauth_callbacks#(?-mix:google_oauth2)

then update our routes:
`````````
  devise_for :users, :path_names => {:sign_in => 'login', :sign_out => 'logout'},
    :controllers => {:registrations => 'users', :omniauth_callbacks => 'omniauth_callbacks'}
`````````

and create this omniauth_callbacks controller!
`````````
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # method name should match strategy name (i.e. google_oauth2 in our case)
  # reminder: our redirect uri is: http://localhost:3000/users/auth/google_oauth2/callback
  def google_oauth2
    user = User.from_omniauth(request.env["omniauth.auth"]) # our own method
    if user.persisted? # a rails method: checks if the user is in the database (if there's an id)
      flash.notice = "Signed in through Google!"
      sign_in_and_redirect user # this is a devise method
    else
      session["devise.user_attributes"] = user.attributes # user.attributes returns a hash of that user object from google; we're stashing this info in our session
      flash.notice = "Problem creating account"
      redirect_to new_user_registration_url
    end
  end

end
`````````

then update our user.rb model:
``````````
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
    # binding.pry # to see what auth contains

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
        user.password = Devise.friendly_token[0,20] # generate a password for that user (because obviously we can't just grab their google password)
        user.skip_confirmation! # change corresponding column in our db as if the user has confirmed their email already so that devise doesn't send a confirm-your-email email (which they have, because they're trying to sign in with google...)
        user
      end
    end

  end

end
``````````

so let's add those provider and uid field to our users table:
➜  gallery_app_omniauth_start git:(w7d2-maloneyl) ✗ rails g migration AddProviderAndUidToUsers provider:string uid:string
      invoke  active_record
      create    db/migrate/20131112150611_add_provider_and_uid_to_users.rb
➜  gallery_app_omniauth_start git:(w7d2-maloneyl) ✗ rake db:migrate
==  AddProviderAndUidToUsers: migrating =======================================
-- add_column(:users, :provider, :string)
   -> 0.0046s
-- add_column(:users, :uid, :string)
   -> 0.0016s
==  AddProviderAndUidToUsers: migrated (0.0076s) ==============================

now if we sign in through google and we're not already a gallery app user:
➜  gallery_app_omniauth_start git:(w7d2-maloneyl) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> User.last
  User Load (1.6ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT 1
=> #<User id: 1, email: "maloney.liu@gmail.com", encrypted_password: "$2a$10$fNDGYCCcLYwjwti0HEcggeHR7u0m3v5v/9gFou1mp5Hw...", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2013-11-12 15:16:44", last_sign_in_at: "2013-11-12 15:16:44", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", confirmation_token: nil, confirmed_at: "2013-11-12 15:16:24", confirmation_sent_at: nil, unconfirmed_email: nil, created_at: "2013-11-12 15:16:24", updated_at: "2013-11-12 15:16:44", role: nil, provider: "google_oauth2", uid: "102082264654192252720">

and if we do binding.pry and see what auth is:
[1] pry(User)> auth
=> {"provider"=>"google_oauth2",
 "uid"=>"102082264654192252720",
 "info"=>
  {"name"=>"Maloney Liu",
   "email"=>"maloney.liu@gmail.com",
   "first_name"=>"Maloney",
   "last_name"=>"Liu",
   "image"=>
    "https://lh6.googleusercontent.com/-8rBQOe8WGAk/AAAAAAAAAAI/AAAAAAAAAE4/gK6fbWSMOlw/photo.jpg",
   "urls"=>{"Google"=>"https://plus.google.com/102082264654192252720"}},
 "credentials"=>
  {"token"=>"ya29.AHES6ZQ57bETR6eBYf7fESKruUUpvXtah3-mUwmZgVBmdA_zuS-WBA",
   "expires_at"=>1384274181,
   "expires"=>true},
 "extra"=>
  {"raw_info"=>
    {"id"=>"102082264654192252720",
     "email"=>"maloney.liu@gmail.com",
     "verified_email"=>true,
     "name"=>"Maloney Liu",
     "given_name"=>"Maloney",
     "family_name"=>"Liu",
     "link"=>"https://plus.google.com/102082264654192252720",
     "picture"=>
      "https://lh6.googleusercontent.com/-8rBQOe8WGAk/AAAAAAAAAAI/AAAAAAAAAE4/gK6fbWSMOlw/photo.jpg",
     "gender"=>"female",
     "locale"=>"en"}}}
[2] pry(User)> auth.class
=> OmniAuth::AuthHash
[3] pry(User)> auth.class.ancestors
=> [OmniAuth::AuthHash,
 Hashie::Mash, # Hashie is a gem that Devise uses and Hashie::Mash is what allows us to do h.foo in addition to h[foo]
 Hashie::PrettyInspect,
 Hashie::Hash,
 Hashie::HashExtensions,
 Hash,
 JSON::Ext::Generator::GeneratorMethods::Hash,
 Enumerable,
 Object,
 PP::ObjectMixin,
 ActiveSupport::Dependencies::Loadable,
 JSON::Ext::Generator::GeneratorMethods::Object,
 Kernel,
 BasicObject]
