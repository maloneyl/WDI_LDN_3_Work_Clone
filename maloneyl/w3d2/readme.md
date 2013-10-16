COMMENTS AND QUESTIONS AFTER HOMEWORK
=====================================

- Understood how to set things up during class and could do the same for the homework, though I haven't got to the CRUD part yet.


*********
HOMEWORK
*********

Remember what we’ve done for planets so far today? Tonight’s task is to get started on moons and do the same thing, as a way to practice what we’ve seen. Look at the class examples and the notes for the past couple of days - you’ve got all you need to get started. 

If you’re feeling confident, try and tackle the CRUD operations - you can do it!


CLASS NOTES
============

0. HOMEWORK REVIEW
******************

pseudo-code:
1. show a form
2. send the form to a function (start line, start station, end line, end station)
3. show the number of stations between departure and arrival

check mta-review.zip

1. RAILS: DB AND MIGRATION
**************************

great db functions you get with Rails!
create_table
drop_table # rails sfollows sql terminology of drop for delete
add_column
change_column
remove_column
rename_column

➜  bookshelf git:(w3d2-maloneyl) ✗ rails g migration CreateBooks name:string
      invoke  active_record
      create    db/migrate/20131015092142_create_books.rb
or without "name:string"

migration up = create
migration down = destroy

db/migrate/20131015092142_create_books.rb:
-----------
  def up
    create_table :books do |t|
      t.string :title
      t.integer :pages_number
      t.string :author
      t.text :content
    end
  end
-----------
when you create_table, Rails will automatically create a primary key. we don't have to do t.primary_key.
as for all the t.[data_type]s, Rails will give you right SQL data type depending on what your database uses, e.g. your t.integer will automatically become postgre's int4 vs. mysql's integer (or something like that)
in general, you don't have to worry about the actual SQL statements because rails does that for you

➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate
==  CreateBooks: migrating ====================================================
-- create_table(:books)
   -> 0.0032s
==  CreateBooks: migrated (0.0034s) ===========================================

can't remember that?
rake -T for all commands
rake -T | grep db for just db-related ones

you'll find your last migration defined with a version in db > migrate > schema.rb

sqlite is the db rails uses by default
you can see the binary version of your data in db > development.sqlite3

timestamp relates to unix time, which began 1 January 1970. our timestamp is the number of seconds since then, without leap seconds.

not that this is recommended, but you can NOT create it manually:
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rails g scaffold reader firstname:string bio:text birthdate:date
then you'll see that db > migrate > 2013XXXXXX_create_readers.rb with lots of code done for you
(again, we're only using scaffold now because we're n00bs)

there's a stack between the database and your migration (your migration is just commands to the database)
each time you run a migration, there's something added to the stack
the migration is the ID you see (2013XXXX), so after that's been done, whatever you add to that same .rb won't be run when you run bundle exec rake db:migrate (rake db:migrate is when you actually run those commands in your migrate file, which then gets the changes into the database)
so if you want to ADD A COLUMN to the CreateBooks table, you don't edit that 2013XXXXXX_create_books.rb; instead you do:
bundle exec rails g migration AddPublishingToBooks publishing:string
then you'll see 2013XXXXX_add_publishing_to_books.rb
---------------
class AddPublishingToBooks < ActiveRecord::Migration
  def change
    add_column :books, :publishing, :string # table name, new field, new field type
  end
end
--------------
and you'll be able to see that change in db > schema.rb

then if you want to REMOVE A COLUMN, you can do it by:
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rails g migration RemovePagesNumberFromBooks
      invoke  active_record
      create    db/migrate/20131015102531_remove_pages_number_from_books.rb
-----------------
class RemovePagesNumberFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :pages_number # table name, column name
  end

  def down
  end
end
-----------------
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate                             
==  RemovePagesNumberFromBooks: migrating =====================================
-- remove_column(:books, :pages_number)
   -> 0.0224s
==  RemovePagesNumberFromBooks: migrated (0.0227s) ============================

to CHANGE A COLUMN'S DATA TYPE/NAME,
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rails g migration ChangeReleasedBooksToDateTime
      invoke  active_record
      create    db/migrate/2013101511XXXX_change_released_books_to_date_time.rb
-----------------
class ChangeReleasedBooksToDateTime < ActiveRecord::Migration
  def up
    change_column :books, :released, :datetime # table name, column name, new data type
  end

  def down
  end
end
-----------------
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rails g migration ChangeReleasedBooksToDateTime
      invoke  active_record
      create    db/migrate/20131015103632_change_released_books_to_date_time.rb
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate                                
==  ChangeReleasedBooksToDateTime: migrating ==================================
-- change_column(:books, :released, :datetime)
   -> 0.0198s
==  ChangeReleasedBooksToDateTime: migrated (0.0207s) =========================

TO RENAME A COLUMN
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rails g migration RenameReleasedToReleaseDate
      invoke  active_record
      create    db/migrate/20131015104929_rename_released_to_release_date.rb
---------------
class RenameReleasedToReleaseDate < ActiveRecord::Migration
  def up
    rename_column :books, :released, :release_date
  end

  def down
  end
end
----------------
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate                              
==  RenameReleasedToReleaseDate: migrating ====================================
-- rename_column(:books, :released, :release_date)
   -> 0.0213s
==  RenameReleasedToReleaseDate: migrated (0.0215s) ===========================

down functions should be the inverse of the up functions; they allow you to rollback
-----------------
class RemovePagesNumberFromBooks < ActiveRecord::Migration
  def up
    remove_column :books, :pages_number # table name, column name
  end

  def down
    add_column :books, :pages_number, :integer # inverse of up, but if you're adding stuff you need to indicate field type
  end
end
-----------------
class ChangeReleasedBooksToDateTime < ActiveRecord::Migration
  def up
    change_column :books, :released, :datetime
  end

  def down
    change_column :books, :released, :date # again, inverse of up
  end
end
-----------------
class RenameReleasedToReleaseDate < ActiveRecord::Migration
  def up
    rename_column :books, :released, :release_date
  end

  def down
    rename_column :books, :release_date, :released # inverse of 'up' 
  end
end
----------------
class AddPublishingToBooks < ActiveRecord::Migration
  def change # then the 'up' and 'down' is accommodated
    add_column :books, :publishing, :string
  end
end
----------------
class CreateBooks < ActiveRecord::Migration

  def up
    create_table :books do |t| # Rails will automatically create a primary key
      t.string :title
      t.integer :pages_number # Rails will change the data type to what your database uses, e.g. postgre's int4 vs. mysql's integer (or something like that)
      t.string :author
      t.text :content
    end
  end

  def down
    drop_table :table # inverse of up
  end
end
----------------

to roll back one migration:
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:rollback
==  RenameReleasedToReleaseDate: reverting ====================================
-- rename_column(:books, :release_date, :released)
   -> 0.0226s
==  RenameReleasedToReleaseDate: reverted (0.0228s) ===========================

to roll back to a specific migration:
grab the timestamp from the filename (the 20131015XXXXXX)
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate:down VERSION=20131015XXXXXX
e.g.
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate:down VERSION=20131015103632
==  ChangeReleasedBooksToDateTime: reverting ==================================
-- change_column(:books, :released, :date)
   -> 0.0222s
==  ChangeReleasedBooksToDateTime: reverted (0.0224s) =========================

you can drop the database (simply with bundle exec rake db:drop), and if you decide you want it back, you can just create a new one (bundle exec rake db:create) and run the migrations again (bundle exec rake db:migrate) because your migrate files are still there so you can just run all the commands again to recreate it
--------------------------
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:drop
Couldn't drop db/test.sqlite3 : #<Errno::ENOENT: No such file or directory - /Users/Maloney/Development/WDI_LDN_3_Work/maloneyl/w3d2/classwork/bookshelf/db/test.sqlite3> # this is the right error
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:create
➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate
==  CreateBooks: migrating ====================================================
-- create_table(:books)
   -> 0.0063s
==  CreateBooks: migrated (0.0069s) ===========================================

==  AddPublishingToBooks: migrating ===========================================
-- add_column(:books, :publishing, :string)
   -> 0.0014s
==  AddPublishingToBooks: migrated (0.0024s) ==================================

==  RemovePagesNumberFromBooks: migrating =====================================
-- remove_column(:books, :pages_number)
   -> 0.0109s
==  RemovePagesNumberFromBooks: migrated (0.0115s) ============================
--------------------------

we've been doing all of this because "class CreateBooks < ActiveRecord::Migration"


2. RAILS: MORE ABOUT ACTIVERECORDS AND METHODS TO USE
******************************************************

app > models > book.rb
-----------
class Book < ActiveRecord::Base

end
-----------

➜  bookshelf git:(w3d2-maloneyl) ✗ bundle exec rails console
Loading development environment (Rails 3.2.14)
irb(main):001:0> Book
=> Book(id: integer, title: string, author: string, content: text, publishing: string, release_date: datetime)
irb(main):002:0> book = Book.new
=> #<Book id: nil, title: nil, author: nil, content: nil, publishing: nil, release_date: nil>
irb(main):003:0> book.title = "Ruby Pickaxe"
=> "Ruby Pickaxe"
irb(main):004:0> book
=> #<Book id: nil, title: "Ruby Pickaxe", author: nil, content: nil, publishing: nil, release_date: nil>
irb(main):005:0> book.author = "Some Clever Guy"
=> "Some Clever Guy"
irb(main):006:0> book
=> #<Book id: nil, title: "Ruby Pickaxe", author: "Some Clever Guy", content: nil, publishing: nil, release_date: nil>
irb(main):007:0> book.content = "This is 400 pages of stuff that I don't get yet"
=> "This is 400 pages of stuff that I don't get yet"
irb(main):008:0> book
=> #<Book id: nil, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: nil>
irb(main):009:0> book.release_date = Time.now
=> 2013-10-15 13:28:58 +0100 # Rails will help you convert it to the SQL format
irb(main):010:0> book
=> #<Book id: nil, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">
irb(main):011:0> book.release_date.class
=> ActiveSupport::TimeWithZone
irb(main):012:0> book.save # you have to save this stuff!
   (0.3ms)  begin transaction
  SQL (12.6ms)  INSERT INTO "books" ("author", "content", "publishing", "release_date", "title") VALUES (?, ?, ?, ?, ?)  [["author", "Some Clever Guy"], ["content", "This is 400 pages of stuff that I don't get yet"], ["publishing", nil], ["release_date", Tue, 15 Oct 2013 12:28:58 UTC +00:00], ["title", "Ruby Pickaxe"]]
   (1.4ms)  commit transaction
=> true
irb(main):014:0> Book.all
  Book Load (0.4ms)  SELECT "books".* FROM "books" 
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">]

ActiveRecord methods:
Class.new
instance.save

now, to create more dummy books, modify book.rb to include:
attr_accessible

then in the rib, do:
reload!
-> so you don't' have to exit your console to see changes you've made in the model since you opened the console

irb(main):016:0> (1..10).to_a.each { |time| book = Book.new(title: "title#{time}");book.save }
   (0.1ms)  begin transaction
  SQL (0.7ms)  INSERT INTO "books" ("author", "content", "publishing", "release_date", "title") VALUES (?, ?, ?, ?, ?)  [["author", nil], ["content", nil], ["publishing", nil], ["release_date", nil], ["title", "title1"]]
etc. etc.
irb(main):018:0> Book.all
  Book Load (0.7ms)  SELECT "books".* FROM "books" 
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil>, etc.

irb(main):019:0> Book.create({title: "title for create"})
   (0.2ms)  begin transaction
  SQL (0.7ms)  INSERT INTO "books" ("author", "content", "publishing", "release_date", "title") VALUES (?, ?, ?, ?, ?)  [["author", nil], ["content", nil], ["publishing", nil], ["release_date", nil], ["title", "title for create"]]
   (3.4ms)  commit transaction
=> #<Book id: 12, title: "title for create", author: nil, content: nil, publishing: nil, release_date: nil>
irb(main):020:0> 

now to find a record:
irb(main):021:0> Book.find 2
  Book Load (0.5ms)  SELECT "books".* FROM "books" WHERE "books"."id" = ? LIMIT 1  [["id", 2]]
=> #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil>
irb(main):022:0> Book.find [2,3]
  Book Load (0.6ms)  SELECT "books".* FROM "books" WHERE "books"."id" IN (2, 3)
=> [#<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 3, title: "title2", author: nil, content: nil, publishing: nil, release_date: nil>]
irb(main):023:0> Book.find_by_title "title3" # dynamic search
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE "books"."title" = 'title3' LIMIT 1
=> #<Book id: 4, title: "title3", author: nil, content: nil, publishing: nil, release_date: nil>
irb(main):024:0> Book.find_by_title_and_author "title3", "" # this is slow but dynamic ruby methods
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE "books"."title" = 'title3' AND "books"."author" = '' LIMIT 1
=> nil
irb(main):025:0> Book.where(title: "title7") # this is faster; and returns an array by default because the where condition can correspond to several rows
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE "books"."title" = 'title7'
=> [#<Book id: 8, title: "title7", author: nil, content: nil, publishing: nil, release_date: nil>]
irb(main):026:0> Book.where({title: "title7"}, {author: nil})
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE "books"."title" = 'title7'
=> [#<Book id: 8, title: "title7", author: nil, content: nil, publishing: nil, release_date: nil>]
irb(main):027:0> Book.where({title: "title7"}, {author: nil}).first # then it won't be an array; use if you know you only need that one result
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE "books"."title" = 'title7' LIMIT 1
=> #<Book id: 8, title: "title7", author: nil, content: nil, publishing: nil, release_date: nil>
irb(main):028:0> Book.where("release_date > ?", Date.today-2.years) # the question mark is 'replaced' by the stuff passed after the comma
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE (release_date > '2011-10-15')
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">]
irb(main):029:0> Book.where("release_date > ?", 2.years.ago) # same as above
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE (release_date > '2011-10-15 12:51:58.276853')
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">]
irb(main):030:0> Book.where("release_date > :release_date", {release_date: 2.years.ago}) # same as above
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE (release_date > '2011-10-15 12:53:25.439854')
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">]
irb(main):031:0> Book.where("release_date > ? AND release_date < ?", 2.years.ago, 1.years.ago) # pass two in order stated
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE (release_date > '2011-10-15 12:54:53.761985' AND release_date < '2012-10-15 12:54:53.762235')
irb(main):001:0> Book.where("id < ?", 5)
  Book Load (0.3ms)  SELECT "books".* FROM "books" WHERE (id < 5)
irb(main):036:0> Book.where("title != ?", "title6") # find anything but title6
  Book Load (0.5ms)  SELECT "books".* FROM "books" WHERE (title != 'title6')
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 3, title: "title2", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 4, title: "title3", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 5, title: "title4", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 6, title: "title5", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 8, title: "title7", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 9, title: "title8", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 10, title: "title9", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 11, title: "title10", author: nil, content: nil, publishing: nil, release_date: nil>, #<Book id: 12, title: "title for create", author: nil, content: nil, publishing: nil, release_date: nil>]
irb(main):035:0> Book.select("title").where(author: "Some Clever Guy") # select something specific (if you don't select() then it's just SELECT *)
  Book Load (0.3ms)  SELECT title FROM "books" WHERE "books"."author" = 'Some Clever Guy'
=> [#<Book title: "Ruby Pickaxe">]
irb(main):037:0> Book.limit(2)
  Book Load (0.3ms)  SELECT "books".* FROM "books" LIMIT 2
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58">, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil>]
irb(main):039:0> Book.where(title: "something").limit(2).offset(3) # get two results starting from 4th row onwards (offset=3 means ignore the first 3 rows of the results, not the original table)

and if there's something you can't do by methods alone and you need to write your own SQL statement, do that with:
Book.find_by_sql("INSERT SQL STATEMENTS HERE")

we probably will only use .where, .create, .save, .all.

irb(main):001:0> Book.where("id < ?", 5)
  Book Load (0.3ms)  SELECT "books".* FROM "books" WHERE (id < 5)
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58", published: nil>, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil, published: nil>, #<Book id: 3, title: "title2", author: nil, content: nil, publishing: nil, release_date: nil, published: nil>, #<Book id: 4, title: "title3", author: nil, content: nil, publishing: nil, release_date: nil, published: nil>]
irb(main):002:0> books = Book.where("id < ?", 5)
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE (id < 5)
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58", published: nil>, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil, published: nil>, #<Book id: 3, title: "title2", author: nil, content: nil, publishing: nil, release_date: nil, published: nil>, #<Book id: 4, title: "title3", author: nil, content: nil, publishing: nil, release_date: nil, published: nil>]
irb(main):003:0> books.each { |book| book.published=true;book.save }
   (0.2ms)  begin transaction
   (0.8ms)  UPDATE "books" SET "published" = 't' WHERE "books"."id" = 1
   (3.5ms)  commit transaction
   (0.1ms)  begin transaction
   (0.5ms)  UPDATE "books" SET "published" = 't' WHERE "books"."id" = 2
   (1.4ms)  commit transaction
   (0.1ms)  begin transaction
   (0.5ms)  UPDATE "books" SET "published" = 't' WHERE "books"."id" = 3
   (0.9ms)  commit transaction
   (0.1ms)  begin transaction
   (0.6ms)  UPDATE "books" SET "published" = 't' WHERE "books"."id" = 4
   (1.4ms)  commit transaction
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58", published: true>, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil, published: true>, #<Book id: 3, title: "title2", author: nil, content: nil, publishing: nil, release_date: nil, published: true>, #<Book id: 4, title: "title3", author: nil, content: nil, publishing: nil, release_date: nil, published: true>]
irb(main):004:0> Book.where(published: true)
  Book Load (0.4ms)  SELECT "books".* FROM "books" WHERE "books"."published" = 't'
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58", published: true>, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil, published: true>, #<Book id: 3, title: "title2", author: nil, content: nil, publishing: nil, release_date: nil, published: true>, #<Book id: 4, title: "title3", author: nil, content: nil, publishing: nil, release_date: nil, published: true>]

lambda makes it possible for Rails to pass it as a method. for the above, you can do:
---------------------
class Book < ActiveRecord::Base
  attr_accessible :title

  scope :published, -> { where(published: true) } # this is a lambda named published
  scope :unpublished, -> { where(published: false) } # you can have one for unpublished too
  scope :by_gerry, -> { where(author: "gerry") # or whatever you want!
  scope :by_author, -> (author) { where(author: author) } # and you can have the lambda take an argument
end
---------------------
then you can call:
irb(main):006:0> Book.published
  Book Load (0.3ms)  SELECT "books".* FROM "books" WHERE "books"."published" = 't'
=> [#<Book id: 1, title: "Ruby Pickaxe", author: "Some Clever Guy", content: "This is 400 pages of stuff that I don't get yet", publishing: nil, release_date: "2013-10-15 12:28:58", published: true>, #<Book id: 2, title: "title1", author: nil, content: nil, publishing: nil, release_date: nil, published: true>, #<Book id: 3, title: "title2", author: nil, content: nil, publishing: nil, release_date: nil, published: true>, #<Book id: 4, title: "title3", author: nil, content: nil, publishing: nil, release_date: nil, published: true>]
irb(main):008:0> Book.unpublished
  Book Load (0.3ms)  SELECT "books".* FROM "books" WHERE "books"."published" = 'f'
=> []
--------------------
making these lambdas makes sense if your website involves showing/getting these things a lot, so you don't need to do the same request over and over

find the last thing created:
irb(main):036:0> book = Book.last
  Book Load (0.4ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT 1


3. RAILS: CALLBACKS AND UPDATING
********************************

before….
after….

----------------
class Book < ActiveRecord::Base
  attr_accessible :title

  scope :published, -> { where(published: true) } # this is a lambda named published
  scope :unpublished, -> { where(published: false) } # you can have one for unpublshed too
  scope :by_gerry, -> { where(author: "gerry") } # you can make lambdas for whatever you want!
  scope :by_author, -> (author) { where(author: author) } # and you can have the lambda take an argument

  before_save do
    puts "This record will be saved soon."
    self.author = "no author" if self.author.nil? # so that if no author is entered, it'll say "no author" in the record  
  end

  after_save do    
    puts "You've just saved the record."
  end

  after_create do
    puts "Your record has been created." # this comes after before_save and before after_save
  end

  after_initialize do 
    puts "You've just initialized a new book."
  end

  before_destroy do 
    puts "We will destroy a book :("
  end

end
----------------

irb(main):024:0> book = Book.new
You've just initialized a new book.
=> #<Book id: nil, title: nil, author: nil, content: nil, publishing: nil, release_date: nil, published: nil>
irb(main):025:0> book.save
   (0.3ms)  begin transaction
This record will be saved soon.
  SQL (0.9ms)  INSERT INTO "books" ("author", "content", "published", "publishing", "release_date", "title") VALUES (?, ?, ?, ?, ?, ?)  [["author", "no author"], ["content", nil], ["published", nil], ["publishing", nil], ["release_date", nil], ["title", nil]]
Your record has been created.
You've just saved the record.
   (2.7ms)  commit transaction
=> true

destroy is not the same as delete (the former runs the call back but no the latter)

irb(main):036:0> book = Book.last
  Book Load (0.4ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT 1
You've just initialized a new book.
=> #<Book id: 18, title: nil, author: "no author", content: nil, publishing: nil, release_date: nil, published: nil>
irb(main):037:0> book.destroy
   (0.2ms)  begin transaction
We will destroy a book :(
  SQL (6.7ms)  DELETE FROM "books" WHERE "books"."id" = ?  [["id", 18]]
   (3.0ms)  commit transaction
=> #<Book id: 18, title: nil, author: "no author", content: nil, publishing: nil, release_date: nil, published: nil>
irb(main):038:0> book = Book.last
  Book Load (0.5ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT 1
You've just initialized a new book.
=> #<Book id: 17, title: nil, author: "no author", content: nil, publishing: nil, release_date: nil, published: nil>
irb(main):039:0> book.delete
  SQL (4.6ms)  DELETE FROM "books" WHERE "books"."id" = 17
=> #<Book id: 17, title: nil, author: "no author", content: nil, publishing: nil, release_date: nil, published: nil>

************

irb(main):040:0> Book.create( {author: "gerry", content: "something"} )
ActiveModel::MassAssignmentSecurity::Error: Can't mass-assign protected attributes: author, content
that error shows up if that thing involved is not made "attr_accessible"

HOW TO UPDATE:
irb(main):045:0> book = Book.last
  Book Load (0.4ms)  SELECT "books".* FROM "books" ORDER BY "books"."id" DESC LIMIT 1
You've just initialized a new book.
=> #<Book id: 20, title: "gerryism", author: "no author", content: "something", publishing: nil, release_date: nil, published: nil>
irb(main):046:0> book.update_attributes({author: "Clems", content: "some other thing"})
   (0.1ms)  begin transaction
This record will be saved soon.
   (0.6ms)  UPDATE "books" SET "author" = 'Clems', "content" = 'some other thing' WHERE "books"."id" = 20
You've just saved the record.
   (3.6ms)  commit transaction
=> true
irb(main):048:0> book.update_attribute(:author, "Clemens")
   (0.2ms)  begin transaction
This record will be saved soon.
   (0.6ms)  UPDATE "books" SET "author" = 'Clemens' WHERE "books"."id" = 20
You've just saved the record.
   (4.5ms)  commit transaction
=> true
irb(main):049:0> book
=> #<Book id: 20, title: "gerryism", author: "Clemens", content: "some other thing", publishing: nil, release_date: nil, published: nil>


4. LAB
*******

➜  classwork git:(w3d2-maloneyl) ✗ rails new planets_app --database=postgresql
➜  classwork git:(w3d2-maloneyl) ✗ cd planets_app 
➜  planets_app git:(w3d2-maloneyl) ✗ rake -T | grep db
rake db:create          # Create the database from DATABASE_URL or config/database.yml for the current Rails.env (use db:create:all to create all dbs in the config)
➜  planets_app git:(w3d2-maloneyl) ✗ subl .   
then go into config > database.yml, remove pool, username and password so that you can use the database without the default security settings
➜  planets_app git:(w3d2-maloneyl) ✗ bundle exec rake db:create
➜  planets_app git:(w3d2-maloneyl) ✗ bundle exec rails g model planet name:string image:text orbit:float diameter:float mass:float moons:integer
      invoke  active_record
      create    db/migrate/20131015145134_create_planets.rb
      create    app/models/planet.rb
      invoke    test_unit
      create      test/unit/planet_test.rb
      create      test/fixtures/planets.yml

then yes, db/migrate/20131015145134_create_planets.rb should be there!
let's add/fix some more stuff there, e.g.
------
      t.integer :moons, limit: 2 # 2 means smallint, which is 2 bytes with a max value of 32767; we're using limit here to save memory
      t.string :planet_type
      t.boolean :rings, null: false, default: false # null: false means it can't be blank, then let's also set default to false
------
and also make sure our app > models > planet.rb have those new items added in the attr_accessible

once that's done, let's run those commands into the db:
➜  planets_app git:(w3d2-maloneyl) ✗ bundle exec rake db:migrate
==  CreatePlanets: migrating ==================================================
-- create_table(:planets)
   -> 0.0305s
==  CreatePlanets: migrated (0.0307s) =========================================

then let's go into the console to check we've got it:
➜  planets_app git:(w3d2-maloneyl) ✗ bundle exec rails c
Loading development environment (Rails 3.2.14)
irb(main):001:0> Planet
=> Planet(id: integer, name: string, image: text, orbit: float, diameter: float, mass: float, moons: integer, planet_type: string, rings: boolean, created_at: datetime, updated_at: datetime)

to create data for the db, go to db > migrate > seeds.rb, and let's populate it with:
p = Planet.create!(name: 'Earth', moons: 1, orbit: 1.0) # the bang (!) will return an error message if it fails; normal .create only returns true or false
p2 = Planet.create!(name: 'Mars', moons: 2, orbit: 1.5)
p3 = Planet.create!(name: 'Jupiter', moons: 67, orbit: 5.2)
then leave that and exit the console
then get the seed implemented with: 
➜  planets_app git:(w3d2-maloneyl) ✗ bundle exec rake db:seed

then let's go back into the console to check that it's been done:
➜  planets_app git:(w3d2-maloneyl) ✗ bundle exec rails c     
Loading development environment (Rails 3.2.14)
irb(main):001:0> Planet.all
  Planet Load (0.7ms)  SELECT "planets".* FROM "planets" 
=> [#<Planet id: 1, name: "Earth", image: nil, orbit: 1.0, diameter: nil, mass: nil, moons: 1, planet_type: nil, rings: false, created_at: "2013-10-15 15:04:34", updated_at: "2013-10-15 15:04:34">, #<Planet id: 2, name: "Mars", image: nil, orbit: 1.5, diameter: nil, mass: nil, moons: 2, planet_type: nil, rings: false, created_at: "2013-10-15 15:04:34", updated_at: "2013-10-15 15:04:34">, #<Planet id: 3, name: "Jupiter", image: nil, orbit: 5.2, diameter: nil, mass: nil, moons: 67, planet_type: nil, rings: false, created_at: "2013-10-15 15:04:34", updated_at: "2013-10-15 15:04:34">]

now let's worry about routes.
go to config > routes.rb
we decide which controller and which method within that controller to route things to
e.g.
  get '/planets' => 'planets#index' # index is just the convention in web dev to list that stuff
  root :to => 'planets#index' # so that if the user is at / instead of knowing to type /planets, it's still that page; and remember to delete "public/index.html" as Rails' comments reminded us to!

now if we go on http://localhost:3000/, we see that Rails is being really nice and telling us what to do next:
  uninitialized constant PlanetsController
so let's go to create a PlanetsController (planets_controller.rb) in our app > controllers
-------
class PlanetsController < ApplicationController # we usually have a new controller inherit from ApplicationController because sometimes we'll create stuff for all controllers
end
-------

now if we go on http://localhost:3000/, we see that Rails is being really nice again, saying:
  The action 'index' could not be found for PlanetsController
so let's define 'index' in PlanetsController

now the new error message on http://localhost:3000/ is: 
  Missing template planets/index, application/index
that's because we haven't created a view, and Rails expects there to be one that's named the same as the controller unless there's a "render :something" specified
so now let's do that:
➜  planets_app git:(w3d2-maloneyl) ✗ mkdir app/views/planets
➜  planets_app git:(w3d2-maloneyl) ✗ touch app/views/planets/index.html.erb
and now if we go on http://localhost:3000/ again, we see a blank page instead of an error, because we now have that index page, just didn't put anything in it (blank is not an error!)

so let's just edit the index.html.erb a bit to see/check that http://localhost:3000/ has that content

and if we want to list all the planets on that index.html.erb page, let's first go into our PlanetsController and grab the list of planets:
-----------
  def index
    @planets = Planet.all
  end 
-----------

then we can reference @planets in index.html.erb too, iterate through the list to print nicely, etc.
-----------
<% @planets.each do |planet| %>
  <p><%= planet.name %> has <%= planet.moons %> moons.</p>
<% end %>
-----------
but why not make it pluralize things properly?
-----------
<% @planets.each do |planet| %>
  <p><%= planet.name %> has <%= pluralize(planet.moons, 'moon') %>.</p>
<% end %>
-----------

great, now let's create more routes because we'll want to do more things than just listing the planets.
let's start with edit:
------------
  get '/planets/:id/edit' => 'planets#edit', :as => 'planet_edit'
------------
the :as bit makes planet_edit_url(@planet) and planet_edit_path(@planet) methods/helpers we can use in our views
_url is the full http://blahblahblah stuff, while _path is the relative link (we normally use the path)
------------
  get    '/planets',          to: 'planets#index',  as: :planets
  post   '/planets',          to: 'planets#create'
  get    '/planets/new',      to: 'planets#new',    as: :new_planet
  get    '/planets/:id/edit', to: 'planets#edit',   as: :edit_planet
  get    '/planets/:id',      to: 'planets#show',   as: :planet
  put    '/planets/:id',      to: 'planets#update'  # update is different from edit; update refers to the form's action
  delete '/planets/:id',      to: 'planets#destroy'  
------------
the above are all rails convention…so let's just stick with them

and then let's spruce up the layouts/application.html.erb and have the global nav link to our index and 'create' page with the helpers we created above!
--------
<nav>
  <%= link_to 'Planets', planets_path %>
  |
  <%= link_to 'New planet', new_planet_path %>
</nav>
--------

and if you go on http://localhost:3000/ now and try that 'New planet' link, you'l see the error message:
  The action 'new' could not be found for PlanetsController
so let's do that (and let's remember to let rails prompt us to do stuff)
and we know from our routes that this new action is supposed to be in planets#new, so let's create a new method in PlanetsController and create a new.html.erb under views > planets


