QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

To come.


HOMEWORK
*********

Over the weekend, you created a rails app that featured a “has_many_through” relationship between “recipes” and “ingredients”. We’ve reviewed the whole process this morning, and saw how to add the “quantities” intermediary model. Your task tonight is to create a simple rails app from scratch that features the following three models: 
  • book (title, author, pages, year)
  • bookshelf (category)
  • library (name, address)

You need to establish the relationships between those models, and ensure that basic CRUD operations are working for all three models. You’ll also want to add validations for the form fields - use the type of validations we learned today.

Remember:
  • a library “has_many” bookshelves
  • a bookshelf “belongs_to” a library
  • a bookshelf “has_many” books
  • a book “belongs_to” a bookshelf
  • a book can “has_one” library “through” bookshelf
  • a library can “has_many” books “through” bookshelf

To complete tonight’s homework, you already have several working examples at your disposal. We WANT to see working code tomorrow!



CLASS NOTES
============


0. HOMEWORK REVIEW / MORE WITH RAILS ASSOCIATIONS
**************************************************

simply by doing "resources :name_pluralized", rails will create the route like the below
at this point it doesn't care that there's no controller/method for it

➜  cookbook git:(w4d1-maloneyl) ✗ rake routes
    ingredients GET    /ingredients(.:format)          ingredients#index
                POST   /ingredients(.:format)          ingredients#create
 new_ingredient GET    /ingredients/new(.:format)      ingredients#new
edit_ingredient GET    /ingredients/:id/edit(.:format) ingredients#edit
     ingredient GET    /ingredients/:id(.:format)      ingredients#show
                PUT    /ingredients/:id(.:format)      ingredients#update
                DELETE /ingredients/:id(.:format)      ingredients#destroy
        recipes GET    /recipes(.:format)              recipes#index
                POST   /recipes(.:format)              recipes#create
     new_recipe GET    /recipes/new(.:format)          recipes#new
    edit_recipe GET    /recipes/:id/edit(.:format)     recipes#edit
         recipe GET    /recipes/:id(.:format)          recipes#show
                PUT    /recipes/:id(.:format)          recipes#update
                DELETE /recipes/:id(.:format)          recipes#destroy

re: migration -- up and down vs. change
when you're creating a table, because you need to indicate the fields of the table, you should use up and down instead of just change
because otherwise when you rollback to re-create, rails won't know what fields to use to create that table

we want to have more specific info about each ingredient for each recipe, so we're not going to have just a simple join table. instead, we'll create another quantities table (which will have its own model so that we can manage its fields)

class CreateQuantities < ActiveRecord::Migration
  def up
    create_table :quantities do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.string :description # for how to use this ingredient for this recipe
      t.decimal :price # for price of this ingredient for this recipe
      t.decimal :quantity
      t.string :measurement
      t.timestamps
    end
  end

  def down
    drop_table :quantities
  end
end

----

class Quantity < ActiveRecord::Base
  belongs_to :recipe # think of it as stuff belonging to one recipe, one ingredient
  belongs_to :ingredient
end

----

class Ingredient < ActiveRecord::Base
  attr_accessible :name, :image
  has_many :quantities
  has_many :recipes, through: :quantities
end

----

class Recipe < ActiveRecord::Base
  attr_accessible :name, :course, :cooktime, :serving_size, :instructions, :image
  has_many :quantities
  has_many :ingredients, through: :quantities
end

nested … parent-child. i.e. a quantity without ingredient or recipe doesn't make sense.

Cookbook::Application.routes.draw do

  resources :ingredients

  resources :recipes do
    resources :quantities
  end
end

now when we rake routes, we'll see quantities nested under recipes, so now we'll always be able to attach a specify quantity to a recipe:

➜  cookbook git:(w4d1-maloneyl) ✗ rake routes    
         ingredients GET    /ingredients(.:format)                            ingredients#index
                     POST   /ingredients(.:format)                            ingredients#create
      new_ingredient GET    /ingredients/new(.:format)                        ingredients#new
     edit_ingredient GET    /ingredients/:id/edit(.:format)                   ingredients#edit
          ingredient GET    /ingredients/:id(.:format)                        ingredients#show
                     PUT    /ingredients/:id(.:format)                        ingredients#update
                     DELETE /ingredients/:id(.:format)                        ingredients#destroy
   recipe_quantities GET    /recipes/:recipe_id/quantities(.:format)          quantities#index
                     POST   /recipes/:recipe_id/quantities(.:format)          quantities#create
 new_recipe_quantity GET    /recipes/:recipe_id/quantities/new(.:format)      quantities#new
edit_recipe_quantity GET    /recipes/:recipe_id/quantities/:id/edit(.:format) quantities#edit
     recipe_quantity GET    /recipes/:recipe_id/quantities/:id(.:format)      quantities#show
                     PUT    /recipes/:recipe_id/quantities/:id(.:format)      quantities#update
                     DELETE /recipes/:recipe_id/quantities/:id(.:format)      quantities#destroy
             recipes GET    /recipes(.:format)                                recipes#index
                     POST   /recipes(.:format)                                recipes#create
          new_recipe GET    /recipes/new(.:format)                            recipes#new
         edit_recipe GET    /recipes/:id/edit(.:format)                       recipes#edit
              recipe GET    /recipes/:id(.:format)                            recipes#show
                     PUT    /recipes/:id(.:format)                            recipes#update
                     DELETE /recipes/:id(.:format)                            recipes#destroy

so now we can do:

class QuantitiesController < ApplicationController

  def new
    @recipe = Recipe.find params[:recipe_id]
    @quantity = @recipe.quantities.new
  end


1. RAILS: INPUT VALIDATION
*************************************

we'll start with basic validation.

1. user fills in a form
2. we send data to the server
3. data is valid?
  -> yes: process the data
  -> no: display back form

in the model, we'll add:
  validates :name, presence: true
where :name refers to the field we want to validate, presence refers to the kind of verification we want to do (here we mean we want to make sure that the name field is never empty)
irb(main):001:0> ingredient = Ingredient.new
=> #<Ingredient id: nil, name: nil, image: nil>
irb(main):002:0> ingredient.name = "snail"
=> "snail"
irb(main):003:0> ingredient.valid? 
=> true
irb(main):004:0> ingredient.name = nil
=> nil
irb(main):005:0> ingredient.valid?
=> false

and if we want the image to also not be empty, we can add:
  validates :image, presence: true
now we'll need BOTH name and image to be present for the validation to be true:
irb(main):006:0> reload!
Reloading...
=> true
irb(main):007:0> ingredient = Ingredient.new
=> #<Ingredient id: nil, name: nil, image: nil>
irb(main):008:0> ingredient.valid?
=> false
irb(main):009:0> ingredient.name = "something"
=> "something"
irb(main):010:0> ingredient.valid?
=> false # because it's not enough for just name to be filled
irb(main):011:0> ingredient.image = "something"
=> "something"
irb(main):012:0> ingredient.valid?
=> true

and what if you want to make sure you only have one entry for each name?
  validates :name, presence: true, uniqueness: true
rails will go through the database to look for any corresponding value. this isn't how we'll do it if the database is super big, but we'll worry about that later.
irb(main):014:0> ingredient = Ingredient.new
=> #<Ingredient id: nil, name: nil, image: nil>
irb(main):015:0> ingredient.name = "potato"
=> "potato"
irb(main):016:0> ingredient.image = "something"
=> "something"
irb(main):017:0> ingredient.valid?
  Ingredient Exists (0.7ms)  SELECT 1 AS one FROM "ingredients" WHERE "ingredients"."name" = 'potato' LIMIT 1
=> true
irb(main):018:0> ingredient.save
   (0.4ms)  begin transaction
  Ingredient Exists (0.3ms)  SELECT 1 AS one FROM "ingredients" WHERE "ingredients"."name" = 'potato' LIMIT 1
  SQL (3.3ms)  INSERT INTO "ingredients" ("image", "name") VALUES (?, ?)  [["image", "something"], ["name", "potato"]]
   (1.3ms)  commit transaction
=> true
irb(main):022:0> ingredient = Ingredient.new
=> #<Ingredient id: nil, name: nil, image: nil>
irb(main):023:0> ingredient.name = "potato"
=> "potato"
irb(main):024:0> ingredient.image = "something again"
=> "something again"
irb(main):025:0> ingredient.valid?
  Ingredient Exists (0.4ms)  SELECT 1 AS one FROM "ingredients" WHERE "ingredients"."name" = 'potato' LIMIT 1
=> false

and now in our IngredientsController, let's modify:
  def create
    @ingredient = Ingredient.new params[:ingredient] # note: must be an instance now because we're reusing it in the form template to be rendered AND be ".new" instead of ".create" so that we can validate before save
    if @ingredient.save # i.e. this can only be true if validation is passed
      redirect_to @ingredient
    else
      render :new # i.e. validation failed and return to form
  end

let's add this to that form to render ('new'):
  = @ingredient.errors
.errors is available for each ActiveRecord model and returns an object

do .errors.inspect if you want to see what's returned, e.g.
  #<ActiveModel::Errors:0x007f937d0d6930 @base=#<Ingredient id: nil, name: "", image: "">, @messages={:name=>["can't be blank"], :image=>["can't be blank"]}>

or use .errors.messages:
  {:name=>["can't be blank"], :image=>["can't be blank"]}

or better yet, .errors.full_messages:
  ["Name can't be blank", "Image can't be blank"]
sure, this native error message isn't directly next to the erroneous field, but it's good enough for our purpose now
so let's make it read better instead of printing an array of strings:
- @ingredient.errors.full_messages.each do |error|
  %li= error

then let's add some styling to it:
%ul.errors
  - @ingredient.errors.full_messages.each do |error|
    %li= error
and in our style.css.scss, we have:
.errors {
  background-color: red;
}

now in the Quantity model, add:
  validates :ingredient_id, presence: true
  validates :recipe_id, presence: true
  validates :quantity, numericality: true
  validates :price, numericality: true  
numericality makes sure that it's a numerical value, not text

and in the QuantitiesController, edit:
  def create
    @recipe = Recipe.find params[:recipe_id]
    @quantity = @recipe.quantities.new params[:quantity]
    if @quantity.save
      redirect_to @recipe
    else
      render :new
    end
  end

and in the form, add:
%ul.errors
  - @quantity.errors.full_messages.each do |error|
    %li= error

and numericality can take a hash and be more specific:
  validates :quantity, numericality: {greater_than: 0}
  validates :price, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 100}  

what happens is:
irb(main):026:0> reload!
Reloading...
=> true
irb(main):027:0> quantity = Quantity.new
=> #<Quantity id: nil, recipe_id: nil, ingredient_id: nil, description: nil, price: nil, quantity: nil, measurement: nil, created_at: nil, updated_at: nil>
irb(main):028:0> quantity.valid?
=> false
irb(main):029:0> quantity.ingredient_id = 12
=> 12
irb(main):030:0> quantity.recipe_id = 2
=> 2
irb(main):031:0> quantity.quantity = 10
=> 10
irb(main):032:0> quantity.price = 200
=> 200
irb(main):033:0> quantity.valid?
=> false
irb(main):034:0> quantity.errors.full_messages
=> ["Price must be less than or equal to 100"]
irb(main):035:0> quantity.price = -10
=> -10
irb(main):036:0> quantity.valid?
=> false
irb(main):037:0> quantity.errors.full_messages
=> ["Price must be greater than or equal to 0"]

you can apply conditional validation, e.g. only require this validation for update and not create:
  validates :ingredient_id, presence: true, on: :update

custom validation: define our own! write the method in that same model file (not controller file!).
  validate :my_own_validator # yes, it's 'validate', not 'validates'

  def my_own_validator
    if Ingredient.count > 0 && self.ingredient_id.present?
    # OR: if Ingredient.count > 0 && self.ingredient_id == nil      
      errors.add(:ingredient_id, "must have a value") # arguments: field, message (and the error message to display will automatically be strung together)
    end  
  end

another way to tag on our own conditional:
  validates :ingredient_id, presence: true, if: ingredient_exists?

  def ingredient_exists?
    Ingredient.count > 0
  end

your validation method can be of any specification -- it's just ruby code.
if in the future we want to categorize ingredients and want to check it...
Ingredient.where("category = vegetables").count > 0

for more reading:
http://edgeguides.rubyonrails.org/active_record_validations.html

more examples:
validates :password, length: ( in: 6..20 ) 
validates :games_played, numericality: { only_integer: true }
validates :name, uniqueness: { case_sensitive: false } # by default case_sensitive is true

and to make sure our recipe doesn't include the same ingredient more than once, we define the scope:
  validates :ingredient_id, uniqueness: { scope: :recipe_id }
and you can have more than one scope if you want to (ignore use case below):
  validates :ingredient_id, uniqueness: { scope: [:recipe_id, :quantity] }  

and you can add your own custom message:
  validates :ingredient_id, uniqueness: { scope: :recipe_id, case_sensitive: false }, message: "rofl" 

and you can pass a proc instead of defining your own method, e.g. that same ingredients_exists? can become
  validates :ingredient_id, presence: true, if: Proc.new { Ingredient.count > 0 }


2. RAILS: CUSTOM HELPERS
************************************

helpers: new_something_path, etc.

number_to_currency quantity.price
-> automatically add the dollar sign to quantity.price

what if you want to use a different currency?
you'll have to calculate it
BUT only logic for DISPLAYING the data should be in the views/templates, NOT calculations/operations
so we can have a helper for that instead
let's build a recipe_helper.rb under helpers
----
module RecipeHelper # yes, singular
  def cost_in_pounds costs
    "£#{(cost/1.62).round(2)}"
  end

  def formatted_quantity quantity
    "#{quantity.quantity} #{quantity.measurement}"
  end 
end
----

basically, the helper merely takes away your operations/calculations from your view
you just move stuff there
you can only access the helper in the associated view

but if you want to access it elsewhere, edit your ApplicationController and do:
  helper_method :formatted_quantity

and put the method in that ApplicationController
  def formatted_quantity quantity
    "#{quantity.quantity} #{quantity.measurement}"
  end 

using the ApplicationHelper for something else…
module ApplicationHelper
  def total_cost recipe
    prices = recipe.quantities.map { |quantity| quantity.price }
    total_price = prices.inject{ |sum, item| sum += item }.round(2)
    total_price_in_pounds = (total_price/1.62).round(2)
    "$#{total_price} or £#{total_price_in_pounds}"
  end
end

now we can show the total cost of the recipe on recipes/index with adding this line:
   = total_cost recipe

