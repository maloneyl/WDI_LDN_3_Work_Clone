QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

- Took quite a lot of time reading up on cancan befor I started the homework. Also spent a good while figuring out and testing the different roles (e.g. trying to remember/see if someone is a moderator and if so what this person should see and not see).

- Spent most of my time wondering how to set up the User-related routes, trying to see whether something should be done manually, whether a custom method was needed, whether simply "resources :users" would suffice and how that changed things. I ended up opting for my own custom edit_role and update_role methods that I routed to, but I still can't get the form to work -- instead it just keeps throwing a "blank new form" error (as if a blank form at /users has been submitted)... Also still not 100% sure I understand what to put down for the path for the "post" (or "put"?).

- Think the overall logic and who-should-see-what should work... Just missing the "edit user role" bit.


HOMEWORK
*********

Modify the cookbook app we made in class…

Add a moderator role:
● add a moderator role
● only a moderator can flag recipes, and see the list of flagged recipes, remember to:
○ add cancan ability info
○ fix controller
○ fix views (i.e. hide links)

Add a chef role:
● add a chef role
● make it so only chefs and admins can create, update or destroy ingredients

Add user related methods views:
● a link in the top left nav that shows a list of all users (i.e. index view)
● add a route and action that lets us show a filtered list of just those users with role admin
● make it so only admins and moderators can see this filtered view
● add a users/edit view that ONLY allows the role of a user to be edited (and NOT name, email etc.)
● make it so that only a user logged in as an admin can change a user's role using this form
○ try to prevent a situation where the last admin removes their own admin status as then their would be no way to change roles anymore

HINT

In all cases, make sure you are securing the controller actions AND hiding links that a user is not authorised to use.


CLASS NOTES
=============

1. ADVANCED ROUTES & CONTROLLERS (E.G. ADD FLAG/FLAGGED TO COOKBOOK)
*********************************************************************************************************

what if you need something other than the standard http verbs?

let's say, you want the option to flag a recipe (as offensive or whatever) and also to view all recipes that have been flagged:

  # DOING IT MANUALLY
  put "/recipes/:id/flag", to: "recipes#flag", as: :flag_recipe
  get "/recipes/flagged", to: "recipes#flagged", as: :flagged_recipes

but of course, rails has a smarter way to do the exact same thing as above:

  resources :recipes do
    member do
      put :flag # member here means a single recipe, i.e. need to pass an ID
    end
    collection do
      get :flagged # collection here means all recipes, i.e. no need to pass an ID
    end
    resources :quantities, only: [:new, :destroy, :create]
  end

so let's get the flagged column in the recipes table for that to happen:

➜  cookbook_start git:(w4d2-maloneyl) ✗ bundle exec rails g migration AddFlaggedToRecipes flagged:boolean
      invoke  active_record
      create    db/migrate/20131022100912_add_flagged_to_recipes.rb
----------
class AddFlaggedToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :flagged, :boolean
  end
end
---------
➜  cookbook_start git:(w4d2-maloneyl) ✗ be rake db:migrate                                                  
==  AddFlaggedToRecipes: migrating ============================================
-- add_column(:recipes, :flagged, :boolean)
   -> 0.0065s
==  AddFlaggedToRecipes: migrated (0.0067s) ===================================

now let's add that link to our index view:
= link_to('New Recipe', new_recipe_path)
\:: #{link_to('Show Flagged Recipes', flagged_recipes_path)}
the backslash is just to escape the colon so that it's not interpreted as a filter (: in haml means a filter call)
and this is just because we want the colons in for the layout to look like "New Recipe :: Show Flagged Recipes"

and on the show page:
\:: #{link_to('Flag Recipe', flag_recipe_path(@recipe), :method => :put)}

so then we need that flag method in the recipes_controller.rb:
  def flag
    @recipe = Recipe.find(params[:id])
    @recipe.flagged = true
    @recipe.save
    render :show
  end

…as well as a flagged
  def flagged
    @recipes = Recipe.where(flagged: true).all 
    render :index
  end

reminder: render is just show the view, not run the code under the method of that name. e.g. we render the index view in flagged, but it doesn't mean that the index method will be run.

but now, even though the flag method works, there's no notification or anything. so let's add a message simply by adding a 'flash':
  def flag
    @recipe = Recipe.find(params[:id])
    @recipe.flagged = true
    @recipe.save
    flash[:notice] = "Recipe flagged!"
    render :show
  end

and we have that showing because we have this in our application.html.haml:
      - flash.each do |name, message|
        %div(class="flash-message flash-#{name}")
          = message
name is where we passed "notice"
and our CSS has flash-notice defined.

standard flash conventions:
notice = everything went well
alert = not well
error = interchangeable with alert

now let's explore the difference between ".save" and ".save!":
------
[1] pry(main)> r = Recipe.new
=> #<Recipe id: nil, name: nil, course: nil, cooktime: nil, servingsize: nil, instructions: nil, image: nil, created_at: nil, updated_at: nil, flagged: nil>
[2] pry(main)> r.valid?
=> false
[3] pry(main)> r.save
   (0.4ms)  BEGIN
   (0.5ms)  ROLLBACK
=> false
[4] pry(main)> r.save!
   (0.4ms)  BEGIN
   (0.3ms)  ROLLBACK
ActiveRecord::RecordInvalid: Validation failed: Name can't be blank, Cooktime can't be blank
from /Users/Maloney/.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/gems/activerecord-3.2.14/lib/active_record/validations.rb:56:in `save!'
[5] pry(main)> r.errors.full_messages 
=> ["Name can't be blank", "Cooktime can't be blank"]
-----
and as we've seen yesterday, we can use .errors.full_messages to show the user the error messages

and things could possibly go wrong with CREATE and UPDATE, so let's fix those:
----
  def create
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect_to @recipe, notice: "Recipe successfully created!"
    else
      flash[:alert] = "Unable to create recipe!"
      render :new
    end
  end
-----
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      redirect_to @recipe, notice: "Recipe succesfully updated!"
    else
      flash[:alert] = "Unable to update recipe!"
      render :edit
    end      
  end
-----

and for the form:

= form_for @recipe do |f|

  - if @recipe.errors.any?
    .error-messages # this is for CSS
      %h2 Form is invalid
      %ul
        - @recipe.errors.full_messages.each do |message|
          %li= message

  .field
    = f.label :name
    %br/
    = f.text_field :name, :autofocus => true

etc. etc.

FILTERS:

we can dry up our code with a filter, e.g. where we find a recipe by its id in show, edit, update, destroy, flag:
  before_filter :find_record, only: [:show, :edit, :update, :destroy, :flag]
but of course, we'll still need to create that find_record once first:
  private
  def find_record
    @recipe = Recipe.find params[:id]
  end
personal choice though whether or not to actually use this filter in this case
you might want to have that little repetition there if it's easier for you to understand what's going on

a more common use case would be to allow logins:
  before_filter :authenticate, except: [:index, :show]
that means, requires logging in to edit, update, etc. but not to just view

and yes, there is after_filter too, albeit not used very often
e.g.
  after_filter :log_something
self-explanatory, really, what you might use and write for the log_something

and then there's an around_filter, which is also not that commonly used.


2. AUTHENTICATION (LOG IN, LOG OUT)
**************************************************

sign up, sign in, sign out

add to routes:
  get "/signup", to: "users#new", as: "signup"
  get "/login", to: "sessions#new", as: "login"
  delete "/logout", to: "sessions#destroy", as: "logout"

and we'll now also need a users_controller.rb and a sessions_controller.rb
users: index, new, create
sessions: new, create, destroy

➜  cookbook_start git:(w4d2-maloneyl) ✗ be rails g migration CreateUsers
      invoke  active_record
      create    db/migrate/20131022124923_create_users.rb
------
class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest # you don't save passwords directly; need encryption
      t.string :role
    end
  end

  def down
    drop_table :users
  end
end
--------
➜  cookbook_start git:(w4d2-maloneyl) ✗ be rake db:migrate
==  CreateUsers: migrating ====================================================
-- create_table(:users)
   -> 0.0217s
==  CreateUsers: migrated (0.0218s) ===========================================

re: password encryption: basically random strings
first byte: encryption system used
second: number of times encryption has been done

MD5 is not secure anymore
there's now a dictionary for MD5 to be decrypted
algorithms change every 4-5 years

for our app now we'll use:
  gem 'bcrypt-ruby', '~> 3.0.0'

we use "has_secure_password" in the user model (and we'll throw in some fancy validation):
class User < ActiveRecord::Base
  has_secure_password # understands password and password confirmation even though neither is a field in the db
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  attr_accessible :email, :name, :role, :password, :password_confirmation
end

[1] pry(main)> user = User.new
=> #<User id: nil, name: nil, email: nil, password_digest: nil, role: nil>
[2] pry(main)> user.email = "gerry@ga.com"
=> "gerry@ga.com"
[3] pry(main)> user.password = "gerry"
=> "gerry"
[4] pry(main)> user.password_confirmation # even when there's no 'password confirmation' as the db field
=> nil
[5] pry(main)> user.password_confirmation = "gerry"
=> "gerry"
[6] pry(main)> user.save
   (0.4ms)  BEGIN
  SQL (13.0ms)  INSERT INTO "users" ("email", "name", "password_digest", "role") VALUES ($1, $2, $3, $4) RETURNING "id"  [["email", "gerry@ga.com"], ["name", nil], ["password_digest", "$2a$10$Pm5p1oioCw3XubLpsQK06OJt/GoNQZOIwmJrC6iA6rCIhAuvn6eOK"], ["role", nil]]
   (1.0ms)  COMMIT
=> true
[7] pry(main)> user.authenticate "gerry"
=> #<User id: 1, name: nil, email: "gerry@ga.com", password_digest: "$2a$10$Pm5p1oioCw3XubLpsQK06OJt/GoNQZOIwmJrC6iA6rCI...", role: nil>
[8] pry(main)> user.authenticate "gerrydsfjkljsf"
=> false
[9] pry(main)> user1 = User.find_by_email "gerry@ga.com"
  User Load (1.7ms)  SELECT "users".* FROM "users" WHERE "users"."email" = 'gerry@ga.com' LIMIT 1
=> #<User id: 1, name: nil, email: "gerry@ga.com", password_digest: "$2a$10$Pm5p1oioCw3XubLpsQK06OJt/GoNQZOIwmJrC6iA6rCI...", role: nil>
[10] pry(main)> user1.authenticate "gerry"
=> #<User id: 1, name: nil, email: "gerry@ga.com", password_digest: "$2a$10$Pm5p1oioCw3XubLpsQK06OJt/GoNQZOIwmJrC6iA6rCI...", role: nil>
[11] pry(main)> user1.authenticate "wdi"
=> false

so let's go to the users_controller to make the new method instantiate a @user = User.new, then create a sign-up form under users/new.html.haml, with some fancy error messages
- if @user.errors.any?
  .error-messages
    %h2 Form is invalid
    %ul
      - @user.errors.full_messages.each do |message|
      %li= message
= form_for(@user) do |f|
  .field
    = f.label :name
    = f.text_field :name
    %br/
  .field
    = f.label :email
    = f.text_field :email    
    %br/
  .field
    = f.label :password
    = f.password_field :password      
    %br/
  .field
    = f.label :password_confirmation
    = f.password_field :password_confirmation
    %br/
  .actions
    = f.submit

add to routes.rb:
  resources :users, only: [:index, :new, :create]
  resources :sessions, only: [:new, :create, :destroy]

now we can access /signup to see that new form!

then for the actual user creation, let's go back to the controller and work on the create method:
  def create
    @user = User.new params[:user]
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thanks for signing up!"
    else 
      render :new
    end
  end

then let's create a sessions/new.html.haml for login
----
%h1 Login

= form_tag sessions_path do
  .field
    = label_tag :email
    %br/
    = email_field_tag :email # new in html5; checks for properly formatted email
  .field
    = label_tag :password
    %br/
    = password_field_tag :password
  .actions
    = submit_tag "Login"
-----
we use form_tag instead of form_for because there's no model and hence no instance attached

and modify the SessionsController:
-----
  def create # the actual sign-in
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password]) # if there is a user associated with the email given and the password is right
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Invalid login credentials"
      render :new
    end
  end
------
flash.now -> flash for every request

and we can create a current_user helper method in application_controller:
----
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
----
i.e. if we already have a value in current_user, we don't do the "User.find…." bit. then we don't have to redo the database query and waste the memory/time from database queries

helper methods can be used in views on top of the controllers (without the helper method you can only use it in the controller)

another helper method to add underneath:

  def logged_in?
    !!current_user
    # current_user returns either nil or user object
    # !current_user will then return either (!nil) or false
    # !! gives you inverse of value IN BOOLEAN
    # try in irb if confused
  end

then let's show this on the main view (views/layouts/application.html.haml) as the top-right nav:
        %ul.right-nav
          %li
            - if current_user
              Logged in as #{current_user.name}
        |
              = link_to 'Logout', logout_path, method: :delete
            - else
              = link_to 'Login', login_path
              or
              = link_to 'Sign Up', signup_path

and in SessionsController, create our destroy method to do logout:
  def destroy
    session[:user_id] = nil
    redirect_to root_url, noticed: "Logged out!"
  end


3. AUTHORIZATION
*************************

authorization lets us show different things to different users
let's say we want to make a recipe editable only by the user who created it

we'll need a gem for it!
help us save time with creating conditionals ourselves or help keep things in one place

➜  cookbook_start git:(w4d2-maloneyl) ✗ rails g migration AddUserIdToRecipes user_id:integer
      invoke  active_record
      create    db/migrate/20131022151253_add_user_id_to_recipes.rb
------
class AddUserIdToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :user_id, :integer
  end
end
------
➜  cookbook_start git:(w4d2-maloneyl) ✗ be rake db:migrate                                  
==  AddUserIdToRecipes: migrating =============================================
-- add_column(:recipes, :user_id, :integer)
   -> 0.0040s
==  AddUserIdToRecipes: migrated (0.0042s) ====================================

put the associations in the models so that we get all the nice methods:
recipe.rb -- belongs_to :user # singular
user.rb -- has_many :recipes # plural

to start over with the database:
➜  cookbook_start git:(w4d2-maloneyl) ✗ rake db:drop
➜  cookbook_start git:(w4d2-maloneyl) ✗ rake db:create
➜  cookbook_start git:(w4d2-maloneyl) ✗ rake db:setup

➜  cookbook_start git:(w4d2-maloneyl) ✗ bundle exec rails g cancan:ability 
      create  app/models/ability.rb

then in that app/models/ability.rb:
-----
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.role? :admin
      can :manage, :all # manage is alias for all standard CRUD; all here means all models
    else
      can :read, :all # read is alias for show, index; can specify as just "can :read, Recipe" or "can :flag, Recipe" if that's what we want
    end
  end
end
-------
only the 'can' methods will be trigged for the user passed

and in models/user.rb, add:
  def role?(r)
    self.role == r.to_s # because db field is always a string; while r could be passed in either symbol or string
  end

let's test it out in the recipes_controller.rb's show:
  def show
    authorize! :read, @recipe # "!" means throw an error    
  end

and now we'll see "You are not authorized to access this page." if we try to access a page (when not logged in as admin)

but we don't need to that manually for all those methods if we simply include this in recipes_controller.rb:
  load_and_authorize_resource
  # as long as all the naming are instance variables and normal rails names,
  # we can now remove @recipes = Recipe.all, @recipe = Recipe.find, etc.
  # in index, new, show, edit,
  # we also don't need to before_filter :find_record anymore

and let's move on to fixing the views so that we don't even show the links to those pages the user cannot access...

'can' is a method cancan added for us to use in all views
so for views/recipes/show, we'll identity what should be shown based on role ability:
- if can? :create, Recipe
  = link_to('New Recipe', new_recipe_path)
- if can? :update, Recipe
  \:: #{link_to('Edit Recipe', edit_recipe_path(@recipe))}
  \:: #{link_to('Add ingredient for recipe', new_recipe_quantity_path(@recipe))}
- if can? :destroy, @recipe  
  \:: #{link_to('Delete Recipe', @recipe, :method => :delete, :confirm => 'Are you sure?')}
- if can? :flag, @recipe
  \:: #{link_to('Flag Recipe', flag_recipe_path(@recipe), :method => :put)}

now if we're logged out, we can still read all recipes
and the nested ingredients on each recipe can still be deleted… to accommodate this nesting, we modify the QuantitiesController because that's where the nested ingredients are controlled:
  load_and_authorize_resource :recipe
  load_and_authorize_resource :quantity, :through => :recipe

and update views/recipes/index to show selectively and include the author associated with the recipe name

and for the ability.rb, here's the master version:
------
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      if user.role?(:author)
        can :create, Recipe
        can :update, Recipe do |recipe| # i.e. can only update the user's own recipe only
          recipe.user == user
        end
        can :destroy, Recipe do |recipe| # i.e. can only update the user's own recipe only
          recipe.user == user
        end
        can :manage, Quantity, :recipe => { :user_id => user.id } # i.e. can only update the user's own recipe only; our recipes table has a user_id, and that should fit user.id
    end
  end
end
------
