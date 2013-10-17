QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

- Comfortable enough about stuff that we did cover in class
- Starting to appreciate some Rails magic with the various FormHelper functions that I tried out, but sometimes it could be hard to know what arguments/parameters are needed (I don't think I know enough about Rails yet to always understand the official docs)
- Displaying the linked movies/actors was fine, but haven't figured out how to add/update/delete the linked records yet
- Didn't know that the table had to be named actors_movies instead of movies_actors to work... Rails magic issues?

HOMEWORK
********

Movies app in Rails 

We built a Movies app a few days ago. Tonight’s assignment, as you might expect, is to recreate the Movies app - but using the Rails framework. 

Following the schema, we should have the following tables in our database:

A movies table...
movies
- title
- release_date
- poster
- director
- rating

… and an actors table:
actors
- first_name
- last_name
- birthdate


Required features:
you have to create a HABTM relationship between the 2 tables
you should create a css stylesheet, and add some styling to your app



CLASS NOTES
===========

0. HOMEWORK REVIEW
******************************

it's good practice to put Moon.delete_all in the seed file in case you need to re-seed

save space with string instead of text for db data type unless you have good reason to believe you'll need more than 255 characters (i.e. the limit of string)

Moon.all
-> gives you an array of all instances of the Moon class instantiated

the view to be rendered is assumed to be in a folder named the same as the controller

and you can "inspect element" in Chrome and see that a field is named/linked to what,
e.g.
   <input id="moon_associated_planet" name="moon[associated_planet]" size="30" type="text">
moon[associated_planet]: where 'moon' is the class passed to form_for, singular; and the [field_name] corresponds to the field name you have in the form
you get all this stuff with formhelper if you stick to rails convention

the params are rails hashes, not real hashes: ActiveSupport:HashWithIndifferentAccess
that means you can use string or symbol as a key and it will still work

**************************
class MoonsController < ApplicationController

  def index
    @moons = Moon.all
  end

  def new
    @moon = Moon.new # this @moon is needed purely to communicate with the view; ruby will garbage-collect eventually
  end

  def create # this is not actually a page so no create.html.erb; it's only used by the form 
    # we don't need @moon here because it doesn't have to communicate with another view
    moon = Moon.new params[:moon] # params[:moon], not params[:field_names]!
    moon.save
    redirect_to moons_url
    # going to the show page would be better (redirect_to moon), but if we don't have that yet, go to index
    # 'render :index' means to render its VIEW only, not to execute the index METHOD where you'd get @moons = Moon.all
    # '_url' must be used instead of '_path' when using 'redirect_to'
  end

end
**************************

1. PLANETS APP EXPANDED: CRUD
**********************************************

continuing planets_app in w3d2 folder

when we load the form in new,
----------
<%= form_for @planet do |f| %>
  Name:
  <%= f.text_field :name %><br />
  <%= f.submit %>
<% end %>
----------
the f.submit is clever enough to give you "Create Planet" as the label text because this is a New page and the Class is Planet

good practices for forms:
  <fieldset>
    <legend>Planet details</legend>
  </fieldset>
fieldset gives you a box, with the legend set within the top-left
then give each field its on div class="field"
    <div class="field">
      <%= f.label :name, 'Name' %> <!-- if you don't pass the string, it'll just be the symbol with capitalize; it's useful if you want to do stuff like 'Diameter (km)' instead of just 'Diameter' -->
      <%= f.text_field :name %>
    </div>
the label and the field have to be the same key so that rails will know they're related. then when you click on the label in the webpage, the text field will be active already (this is good for usability)

there are more than just text_field!

url field:
<%= f.url_field :image %>

number field:
<%= f.number_field :orbit, step: :any %>
number_field requires a step size (default is 1 integer)

radio button:
      <%= f.label :planet_type, 'Planet Type' %>
      <% ['rocky', 'gas-giant'].each do |type| %>
        <%= f.radio_button :planet_type, type, checked: @planet.planet_type == type %>
        <%= f.label "planet_planet_type_#{type}", type, class: 'checkbox-label' %>
      <% end %>
the label should match the radio_button id (which we can grab from Inspect Element); the class bit is for css

check box:
<%= f.check_box :rings %>

you never use the text_field_tag, number_field_tag, etc. versions within a form

in our routes:
  post   '/planets',          to: 'planets#create'
that means when you send the form, the url will be appended with all the ?name=XXX&planet_type=XXX

let's build the show page:
<% if @planet.image.present? %> <!-- i.e. empty strings won't count as true -->
  <%= image_tag @planet.image, class: 'large-image' %>
<% end %>  

more about helpers:
  <%= link_to "Destroy this planet!", @planet, :method => :delete, :confirm => "Whoa there! Are you sure you want to destroy #{@planet.name}?" %>
** the link is just the object; rails can figure out the rest if you have the method specified, and the method here refers to the http verb (delete), not our controller's method (destroy))
  <%= link_to "Edit this planet", edit_planet_path(@planet.id) %>
** or again, simply edit_planet_path(@planet) for rails to figure out that it's the id we need in the params  

difference of .destroy and .delete in rails:
destroy calls callback; delete doesn't

and for edit, we can reuse the same form, but instead of simply rendering the new view, let's make the form a partial (_form.html.erb) and then render that partial
that way things are semantically clearer

and now you'll also see that the default submit button's verb is 'Update' on the edit version and 'Create' on the view version

then for the actual update action,
  def update # what the form does (vs. 'edit' which is just the view with the form)
    planet = Planet.find params[:id]
    planet.update_attributes params[:planet]
    redirect_to planet
  end

to re-seed our db, we do a different seed.rb, then drop our db, re-create it, re-add the tables and columns from our migrate file, re-seed:
➜  planets_app git:(w3d3-maloneyl) ✗ bundle exec rake db:drop
➜  planets_app git:(w3d3-maloneyl) ✗ bundle exec rake db:create
➜  planets_app git:(w3d3-maloneyl) ✗ bundle exec rake db:migrate
==  CreatePlanets: migrating ==================================================
-- create_table(:planets)
   -> 0.0262s
==  CreatePlanets: migrated (0.0264s) =========================================
➜  planets_app git:(w3d3-maloneyl) ✗ bundle exec rake db:seed   

2. DEBUGGING TOOLS FOR RAILS
********************************************

one old-school way to debug is to look at logs

log > development.log
it can get super long if you've worked on your app for a long time
this is neither very practical (because of memory) or useful

show end of file:
➜  planets_app_solution git:(w3d3-maloneyl) ✗ tail log/development.log

set follow:
➜  planets_app_solution git:(w3d3-maloneyl) ✗ tail -f log/development.log
then you can view your actions (what you do in your browser) in the shell

➜  planets_app_solution git:(w3d3-maloneyl) ✗ tail -f usr/loca/var/postgre/server.log
but you'll have to config your postgresql.conf (official class notes will have more)
tailing the postgre/server.log will get you very detailed db stuff if you have trouble getting complicated db stuff

rails log levels:
debug (default in development mode), info (default in production mode), warn, error, fatal
to change the production mode's log info, you can just open up config > environments > production and visit comment lines 33-34

we are manually starting a server in our console, and that's why we don't need to tail the log
we'll need to do logger commands in real projects so that we can get useful info in the real log

e.g. under our PlanetsController, we do:
  def index
    logger.info "about to render index..."
    @planets = Planet.order(:orbit).all
  end

then we try to load that index page in our browser, and this will be printed in the console:
******CONSOLE*******
Started GET "/planets" for 127.0.0.1 at 2013-10-16 14:00:41 +0100
Processing by PlanetsController#index as HTML
about to render index...
  Planet Load (0.6ms)  SELECT "planets".* FROM "planets" ORDER BY orbit
  Rendered planets/index.html.erb within layouts/application (8.0ms)
Completed 200 OK in 49ms (Views: 15.9ms | ActiveRecord: 5.4ms)
******/CONSOLE*******

another way to debug is to print things out, e.g.
  add <%= debug @planet %> to the show page
then visit a planet/X page:
--- !ruby/object:Planet
attributes:
  id: 3
  name: Venus
  image: http://upload.wikimedia.org/wikipedia/commons/5/51/Venus-real.jpg
  orbit: 0.723
  diameter: 0.95
  mass: 0.815
  moons: 0
  planet_type: rocky
  rings: false
  created_at: 2013-10-16 11:38:39.789583000 Z
  updated_at: 2013-10-16 11:38:39.789583000 Z
that prints stuff

and another way to debug is to uncomment out from our Gemfile the gem pry-rails and the gem pry-byebug
and if we have new gems, we need to run 'bundle install' or just 'bundle'
➜  planets_app_solution git:(w3d3-maloneyl) ✗ bundle                     
Resolving dependencies...
…
Your bundle is complete!
Use `bundle show [gemname]` to see where a bundled gem is installed.
then restart your server
then now we'll be using pry instead of irb:
➜  planets_app_solution git:(w3d3-maloneyl) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> 
and now you can put your binding.pry in your ruby file and do the usual

another gem for debugging:
  # fancy pants rails error messages with REPL in the browser
  gem 'better_errors'
  gem 'binding_of_caller'
they work together
it's like binding.pry in a browser, with the error line highlighted
and you can step back to the method that called this
you might want to throw in a divide-by-zero error in your code if you want to take a look at how things work around that block of code
"all frames" show you everything that rails has done for you behind the scenes too…
(A) means application stuff you've written
( ) means it's gems and magic

REMEMBER to keep all these gems under group :development in your Gemfile, never under :production!

another tool is RailsPanel the Chrome extension
which also needs the gem meta_request
then there'll be a Rails tab within your Chrome Developer Tool
the numbers under DB, View, etc. are milliseconds spent to load
but don't rely on the log and error tabs there 

3. RAILS/ACTIVERECORD ASSOCIATIONS
***********************

6 main associations:
  • belongs_to
  • has_one
  • has_many
  • has_one_through
  • has_many_through
  • has_and_belongs_to_many (HABTM)

so let's do a new library app:
➜  classwork git:(w3d3-maloneyl) ✗ rails new library
➜  w3d3 git:(w3d3-maloneyl) ✗ cd classwork/library 
➜  library git:(w3d3-maloneyl) ✗ rails g migration CreateBooksAndBookshelves
      invoke  active_record
      create    db/migrate/20131016134119_create_books_and_bookshelves.rb

convention: singular in model (because that takes care of a Class and its instances), plural for tables

in that migrate/2013XXXXXX.rb file,
-------------------
class CreateBooksAndBookshelves < ActiveRecord::Migration
  
  def up
    create_table :bookshelves do |t|
      t.string "name"
      t.integer "quantity"
    end

    create_table :books do |t|
      t.string "title"
      t.integer "number_of_pages"
      t.belongs_to :bookshelf # this will create a field named bookshelf_id (this is just whatever name you have there plus an underscore plus id, no other magic)
    end
-------------------

➜  library git:(w3d3-maloneyl) ✗ bundle exec rake db:migrate
==  CreateBooksAndBookshelves: migrating ======================================
-- create_table(:bookshelves)
   -> 0.0026s
-- create_table(:books)
   -> 0.0019s
==  CreateBooksAndBookshelves: migrated (0.0047s) =============================

then create app > models > book.rb and bookshelf.rb
make sure both inherit from ActiveRecord::Base 
------------------
class Book < ActiveRecord::Base
  belongs_to :bookshelf
end

class Bookshelf < ActiveRecord::Base
  has_many :books
end
------------------
rails is smart enough to know that the class Book is related to the table books (because it uses a dictionary, and yes, sometimes it runs into errors)

and the belongs_to and has_many have created a lot of functions for you:

irb(main):001:0> book = Book.new
=> #<Book id: nil, title: nil, number_of_pages: nil, bookshelf_id: nil>
irb(main):002:0> bookshelf = Bookshelf.new
=> #<Bookshelf id: nil, name: nil, quantity: nil>
irb(main):003:0> book.bookshelf
=> nil
irb(main):005:0> bookshelf.books
=> []

-----we'll come back to these------
irb(main):006:0> book.bookshelf DOUBLE-TAB
these are all the methods you can have:
book.bookshelf                      book.bookshelf=                     book.bookshelf_id                 
book.bookshelf_id=                  book.bookshelf_id?                  book.bookshelf_id_before_type_cast
book.bookshelf_id_change            book.bookshelf_id_changed?          book.bookshelf_id_was             
book.bookshelf_id_will_change!  
---------------------------------------------

irb(main):006:0> book.title = "a title"
=> "a title"
irb(main):007:0> bookshelf.name = "my first bookshelf"
=> "my first bookshelf"
irb(main):008:0> book.bookshelf = bookshelf
=> #<Bookshelf id: nil, name: "my first bookshelf", quantity: nil>
irb(main):009:0> bookshelf.name = "my first bookshelf again"
=> "my first bookshelf again"
irb(main):010:0> book.bookshelf
=> #<Bookshelf id: nil, name: "my first bookshelf again", quantity: nil> # see, the bookshelf name change is reflected already
irb(main):011:0> book.bookshelf.quantity
=> nil
irb(main):012:0> book.bookshelf.quantity = 200
=> 200
irb(main):013:0> bookshelf
=> #<Bookshelf id: nil, name: "my first bookshelf again", quantity: 200> # again, we don't need to change 'bookshelf' the variable directly ourselves
irb(main):014:0> book.save
   (0.3ms)  begin transaction
  SQL (9.2ms)  INSERT INTO "bookshelves" ("name", "quantity") VALUES (?, ?)  [["name", "my first bookshelf again"], ["quantity", 200]]
  SQL (0.4ms)  INSERT INTO "books" ("bookshelf_id", "number_of_pages", "title") VALUES (?, ?, ?)  [["bookshelf_id", 1], ["number_of_pages", nil], ["title", "a title"]]
   (1.4ms)  commit transaction
=> true
LOGIC: bookshelf is saved first because otherwise book doesn't have a bookshelf_id. bookshelf doesn't rely on book, but book can't be without a bookshelf

you can't assign an object directly into a master (the "has_many"), i.e. you CANNOT do:
irb(main):024:0> bookshelf.books = book1
NoMethodError: undefined method `each' for #<Book:0x007ff39a6ea830>
because the bookshelf.books is an array
so you need to bookshelf.books.push book1 and bookshelf.books.push book2:
------------------
irb(main):025:0> bookshelf.books.push book1
   (0.3ms)  begin transaction
  SQL (0.7ms)  INSERT INTO "books" ("bookshelf_id", "number_of_pages", "title") VALUES (?, ?, ?)  [["bookshelf_id", 1], ["number_of_pages", nil], ["title", "book1"]]
   (3.1ms)  commit transaction
=> [#<Book id: 2, title: "book1", number_of_pages: nil, bookshelf_id: 1>]
irb(main):026:0> bookshelf.books.push book2
   (0.2ms)  begin transaction
  SQL (0.7ms)  INSERT INTO "books" ("bookshelf_id", "number_of_pages", "title") VALUES (?, ?, ?)  [["bookshelf_id", 1], ["number_of_pages", nil], ["title", "book2"]]
   (7.1ms)  commit transaction
=> [#<Book id: 2, title: "book1", number_of_pages: nil, bookshelf_id: 1>, #<Book id: 3, title: "book2", number_of_pages: nil, bookshelf_id: 1>]
irb(main):027:0> bookshelf.books
=> [#<Book id: 2, title: "book1", number_of_pages: nil, bookshelf_id: 1>, #<Book id: 3, title: "book2", number_of_pages: nil, bookshelf_id: 1>]
irb(main):028:0> bookshelf.save
   (0.2ms)  begin transaction # this inserts stuff into the bookshelves table first before the books table
   (0.2ms)  commit transaction
=> true
------------------

ANOTHER EXAMPLE, NOW WITH CARS!

class Garage < ActiveRecord::Base
  has_many :cars
end

class Car < ActiveRecord::Base # with a garage_id
  belongs_to :garage
end

car = Car.new
garage = Garage.new

garage.cars #=> []
car.garage #=> nil
car.garage = garage
garage.cars.push car OR garage.cars << car OR garage.cars = [car]

--------------------

NOW ON TO HAS_ONE_THROUGH:

bookstores -- bookshelves -- books

books: id, …, …, bookshelf_id
  BELONGS_TO
  HAS_MANY
bookshelves: id, …, library_id
  BELONGS_TO
  HAS_MANY
bookstores: id, …
  bookstore has_many :books through :bookshelf
  book has_one :library through :bookshelf

so let's add that!
--------
➜  library git:(w3d3-maloneyl) ✗ rails g migration CreateBookstores
      invoke  active_record
      create    db/migrate/20131016145049_create_bookstores.rb
--------
class CreateBookstores < ActiveRecord::Migration
  def up
    create_table :bookstores do |t|
      t.string :name
    end

    add_column :bookshelves, :bookstore_id, :integer
  end

  def down
  end
end
---------
➜  library git:(w3d3-maloneyl) ✗ bundle exec rake db:migrate

SO NOW THE RELATIONS ARE:
class Bookstore < ActiveRecord::Base
  has_many :bookshelves
  has_many :books, through: :bookshelves
end
class Bookshelf < ActiveRecord::Base
  has_many :books
  belongs_to :bookstore
end
class Book < ActiveRecord::Base
  belongs_to :bookshelf
  has_one :bookstore, through: :bookshelf
end

****
irb(main):001:0> Bookstore
=> Bookstore(id: integer, name: string)
irb(main):002:0> bookstore = Bookstore.new
=> #<Bookstore id: nil, name: nil>
irb(main):004:0> bookstore.bookshelves
=> []
irb(main):005:0> bookshelf = Bookshelf.new
=> #<Bookshelf id: nil, name: nil, quantity: nil, bookstore_id: nil>
irb(main):006:0> bookshelf.books
=> []
irb(main):007:0> bookstore
=> #<Bookstore id: nil, name: nil>
irb(main):009:0> bookstore.save
   (0.3ms)  begin transaction
  SQL (5.9ms)  INSERT INTO "bookstores" ("name") VALUES (?)  [["name", nil]]
   (3.1ms)  commit transaction
=> true
irb(main):010:0> bookstore.bookshelves.create
   (0.3ms)  begin transaction
  SQL (0.9ms)  INSERT INTO "bookshelves" ("bookstore_id", "name", "quantity") VALUES (?, ?, ?)  [["bookstore_id", 1], ["name", nil], ["quantity", nil]]
   (1.4ms)  commit transaction
=> #<Bookshelf id: 2, name: nil, quantity: nil, bookstore_id: 1>
irb(main):014:0> book = Book.new
=> #<Book id: nil, title: nil, number_of_pages: nil, bookshelf_id: nil>
irb(main):015:0> book.bookstore
=> nil
irb(main):016:0> book.title = "rofl"
=> "rofl"
irb(main):017:0> bookshelf = Bookshelf.new
=> #<Bookshelf id: nil, name: nil, quantity: nil, bookstore_id: nil>
irb(main):018:0> bookshelf.name = "funny bookshelf"
=> "funny bookshelf"
irb(main):019:0> bookstore = Bookstore.new
=> #<Bookstore id: nil, name: nil>
irb(main):020:0> bookstore.name = "Hahaha"
=> "Hahaha"
irb(main):021:0> bookstore.bookshelves << bookshelf
=> [#<Bookshelf id: nil, name: "funny bookshelf", quantity: nil, bookstore_id: nil>]
irb(main):022:0> bookshelf.books << book
=> [#<Book id: nil, title: "rofl", number_of_pages: nil, bookshelf_id: nil>]
irb(main):023:0> book.save
   (0.2ms)  begin transaction
  SQL (1.0ms)  INSERT INTO "books" ("bookshelf_id", "number_of_pages", "title") VALUES (?, ?, ?)  [["bookshelf_id", nil], ["number_of_pages", nil], ["title", "rofl"]]
   (3.3ms)  commit transaction
=> true
irb(main):024:0> bookshelf.save
   (0.3ms)  begin transaction
  SQL (0.8ms)  INSERT INTO "bookshelves" ("bookstore_id", "name", "quantity") VALUES (?, ?, ?)  [["bookstore_id", nil], ["name", "funny bookshelf"], ["quantity", nil]]
   (0.3ms)  UPDATE "books" SET "bookshelf_id" = 3 WHERE "books"."id" = 4
   (4.5ms)  commit transaction
=> true
irb(main):025:0> bookstore.save
   (0.3ms)  begin transaction
  SQL (0.8ms)  INSERT INTO "bookstores" ("name") VALUES (?)  [["name", "Hahaha"]]
   (0.3ms)  UPDATE "bookshelves" SET "bookstore_id" = 2 WHERE "bookshelves"."id" = 3
   (4.6ms)  commit transaction
=> true
irb(main):026:0> bookstore = Bookstore.last
  Bookstore Load (0.5ms)  SELECT "bookstores".* FROM "bookstores" ORDER BY "bookstores"."id" DESC LIMIT 1
=> #<Bookstore id: 2, name: "Hahaha">
irb(main):027:0> bookstore.books
  Book Load (0.3ms)  SELECT "books".* FROM "books" INNER JOIN "bookshelves" ON "books"."bookshelf_id" = "bookshelves"."id" WHERE "bookshelves"."bookstore_id" = 2
=> [#<Book id: 4, title: "rofl", number_of_pages: nil, bookshelf_id: 3>]
irb(main):028:0> bookstore.bookshelves.first
  Bookshelf Load (0.4ms)  SELECT "bookshelves".* FROM "bookshelves" WHERE "bookshelves"."bookstore_id" = 2 LIMIT 1
=> #<Bookshelf id: 3, name: "funny bookshelf", quantity: nil, bookstore_id: 2>
irb(main):029:0> book = Book.last
  Book Load (0.4ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT 1
=> #<Book id: 4, title: "rofl", number_of_pages: nil, bookshelf_id: 3>
irb(main):030:0> book.bookstore
  Bookstore Load (0.4ms)  SELECT "bookstores".* FROM "bookstores" INNER JOIN "bookshelves" ON "bookstores"."id" = "bookshelves"."bookstore_id" WHERE "bookshelves"."id" = 3 LIMIT 1
=> #<Bookstore id: 2, name: "Hahaha">
****

and a book can also belong to an author and an author can have lots of books!

new authors table to create AND an authors_books table:
➜  library git:(w3d3-maloneyl) ✗ bundle exec rails g migration CreateAuthors
      invoke  active_record
      create    db/migrate/20131016153405_create_authors.rb
*************************
class CreateAuthors < ActiveRecord::Migration

  def change
    create_table :authors do |t|
      t.string "firstname"
      t.string "lastname"
    end

    create_table :authors_books, id: false do |t|  # i.e. no primary/specific key
      t.integer :author_id
      t.integer :book_id
    end
  end

end
*************************
➜  library git:(w3d3-maloneyl) ✗ bundle exec rake db:migrate
==  CreateAuthors: migrating ==================================================
-- create_table(:authors)
   -> 0.0131s
-- create_table(:authors_books, {:id=>false})
   -> 0.0012s
==  CreateAuthors: migrated (0.0147s) =========================================

author.rb to create and book.rb to update:
--------------------
class Book < ActiveRecord::Base
  belongs_to :bookshelf
  has_one :bookstore, through: :bookshelf
  has_and_belongs_to_many :authors
end

class Author < ActiveRecord::Base
  has_and_belongs_to_many :books
end
---------------------

so now we can do:
irb(main):001:0> book = Book.new
=> #<Book id: nil, title: nil, number_of_pages: nil, bookshelf_id: nil>
irb(main):003:0> author1 = Author.new
=> #<Author id: nil, firstname: nil, lastname: nil>
irb(main):004:0> author1.firstname = 'Sharif'
=> "Sharif"
irb(main):006:0> author2 = Author.new
=> #<Author id: nil, firstname: nil, lastname: nil>
irb(main):007:0> author2.firstname = 'Clemens'
=> "Clemens"
irb(main):008:0> book.authors 
=> []
irb(main):009:0> book.authors << author1
=> [#<Author id: nil, firstname: "Sharif", lastname: nil>]
irb(main):010:0> book.authors << author2
=> [#<Author id: nil, firstname: "Sharif", lastname: nil>, #<Author id: nil, firstname: "Clemens", lastname: nil>]
irb(main):011:0> book.authors
=> [#<Author id: nil, firstname: "Sharif", lastname: nil>, #<Author id: nil, firstname: "Clemens", lastname: nil>]
now if you save the book, it's actually saving into books, authors (author1), authors (author2), authors_books:
irb(main):012:0> book.save
   (0.2ms)  begin transaction
  SQL (9.3ms)  INSERT INTO "books" ("bookshelf_id", "number_of_pages", "title") VALUES (?, ?, ?)  [["bookshelf_id", nil], ["number_of_pages", nil], ["title", nil]]
  SQL (0.4ms)  INSERT INTO "authors" ("firstname", "lastname") VALUES (?, ?)  [["firstname", "Sharif"], ["lastname", nil]]
   (0.2ms)  INSERT INTO "authors_books" ("book_id", "author_id") VALUES (5, 1)
  SQL (0.1ms)  INSERT INTO "authors" ("firstname", "lastname") VALUES (?, ?)  [["firstname", "Clemens"], ["lastname", nil]]
   (0.1ms)  INSERT INTO "authors_books" ("book_id", "author_id") VALUES (5, 2)
   (1.5ms)  commit transaction
=> true
