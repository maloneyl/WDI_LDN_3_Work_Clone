QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

- I think there is too much magic with Rails that's not been explained yet that I'm at the most confused I've been in the course so far. It's difficult not knowing how the code works. Even after hours of reading the suggested docs and experimenting with the homework, I still have rather vague idea of how Rails works.

- Quite confused as to how to structure the app in Rails. Pretty sure there's a different Rails-y way to build this app instead of what I've done here, but after hours of little luck, I decided to just code it to at least work... Did put in some Rails touches with the pluralize and link helpers though.

- Hope tomorrow will be better!

*********
HOMEWORK
*********

Take the MTA app from week one, and put those subway lines on Rails

There are 3 subway lines:

The N line has the following stops:

Times Square, 34th, 28th, 23rd, Union Square, and 8th

The L line has the following stops:

8th, 6th, Union Square, 3rd, and 1st

The 6 line has the following stops:

Grand Central, 33rd, 28th, 23rd, Union Square, and Astor Place.

All 3 subway lines intersect at Union Square, but there are no other intersection points.

(For example, this means the 28th stop on the N line is different than the 28th stop on the 6 line.)

If you want a challenge to extend the logic, add the "7" line, which has stops at Times Square, 42nd, 5th Ave, Grand Central, and Vernon-Jackson - with intersections at TS (N line) and GC (6 line)

Read:
http://guides.rubyonrails.org/routing.html
http://guides.rubyonrails.org/action_controller_overview.html
http://api.rubyonrails.org/classes/ActionView/Helpers/FormTagHelper.html#method-i-form_tag


CLASS NOTES
============

Rails, created in 2004 by DHH of 37 Signals 
extracted from BaseCamp project management tool

Sinatra, created in 2007 by Blake Mizerany of Heroku
felt Rails was overbloated: computer resources, time spent learning

both are rack apps

gem install rails -v=3.2.14
rbenv rehash <-- rbenv lets you have multiple versions of ruby

rails new my_first_rails_app --database=postgresql
^-- we're forcing rails to use postgresql as the database; otherwise rails' default is sqllite

generators == easy life!

for our blog app:
-----------------------
bundle exec rails g scaffold post title:string text:text
bundle exec rails g model comment post_id:integer text:text
bundle exec rails g controller comments create
-----------------------

rails generators quickly scaffold our app
considered semi-bad practice because it's too much magic
we'll write on our own instead of using this default later

rake == easy life too! 

rails does a lot of stuff for you: no need to require_relative, can use a lot of third-party plug-ins
rails favors conventions over configurations: if you place things where they should be and name things what they should be in convention, you get a lot of stuff for free

config folder shouldn't be changed much, by convention
environments: modes in which to run the code
-- development, production, test (e.g. development includes more auto-reload, pry and any other tools, vs. the lean and mean production mode; when you run 'rails s', it's loaded in development mode)
initializers: everything will be run there when your app starts up
locales: translate different languages; database
database.yml: usually the first thing you change when creating a Rails app because it depends on what you're using
routes.rb: …

Gemfile: all your gems! with version number included. also can specify when/where those gems are needed. e.g. if we only need pry (for rails) in development mode, we can do:
----
group :development do
  gem 'pry-rails'
end
----
if you don't have pry-rails install yet, we'll need to do a 'bundle install' in the shell

rails c
= rails console
-> it opens up an rib for Ruby
➜  my_first_rails_app git:(w3d1-maloneyl) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> 

app folder: ze most important
-- models, views, controllers and others

our app folder's models' folder have comment.rb and post.rb because we created them when we ran the scaffolding bundle exec stuff

and in post.rb, we see:
------
class Post < ActiveRecord::Base 
  attr_accessible :text, :title
end
------
inherited a whole bunch of stuff already!

let's add:
-----
  def word_count
    text.split.size
  end


you can check how the Post model looks like in pry:
[1] pry(main)> Post
=> Post(id: integer, title: string, text: text, created_at: datetime, updated_at: datetime)


def initialize(params) # where params is a hash
end

[2] pry(main)> p = Post.new title: "Created in console", text: "Blah, blah, blah."
=> #<Post id: nil, title: "Created in console", text: "Blah, blah, blah.", created_at: nil, updated_at: nil>
[3] pry(main)> p.word_count
=> 3


[4] pry(main)> p.title
=> "Created in console"
[5] pry(main)> p.text
=> "Blah, blah, blah."
[6] pry(main)> p.title = p.title + "!!!"
=> "Created in console!!!"
[7] pry(main)> p.id
=> nil # because it hasn't been in the database yet, and the database is what's responsible for giving you an id:
[8] pry(main)> p.save # which will then get you the whole SQL command written for you!
   (0.3ms)  BEGIN
  SQL (13.8ms)  INSERT INTO "posts" ("created_at", "text", "title", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["created_at", Mon, 14 Oct 2013 11:03:33 UTC +00:00], ["text", "Blah, blah, blah."], ["title", "Created in console!!!"], ["updated_at", Mon, 14 Oct 2013 11:03:33 UTC +00:00]]
   (1.4ms)  COMMIT
=> true
[9] pry(main)> p.id
=> 2
[10] pry(main)> p.created_at
=> Mon, 14 Oct 2013 11:03:33 UTC +00:00
[12] pry(main)> p.updated_at
=> Mon, 14 Oct 2013 11:03:33 UTC +00:00

[13] pry(main)> Post.find(2)
  Post Load (1.4ms)  SELECT "posts".* FROM "posts" WHERE "posts"."id" = $1 LIMIT 1  [["id", 2]]
=> #<Post id: 2, title: "Created in console!!!", text: "Blah, blah, blah.", created_at: "2013-10-14 11:03:33", updated_at: "2013-10-14 11:03:33">
[14] pry(main)> Post.all
  Post Load (0.6ms)  SELECT "posts".* FROM "posts" 
=> [#<Post id: 1, title: "First post with Rails", text: "Hello, hello. We are creating our first blog post, ...", created_at: "2013-10-14 10:02:07", updated_at: "2013-10-14 10:02:07">,
 #<Post id: 2, title: "Created in console!!!", text: "Blah, blah, blah.", created_at: "2013-10-14 11:03:33", updated_at: "2013-10-14 11:03:33">]
[15] pry(main)> Post.count
   (0.6ms)  SELECT COUNT(*) FROM "posts" 
=> 2

➜  my_first_rails_app git:(w3d1-maloneyl) ✗ rails c
Loading development environment (Rails 3.2.14)
[1] pry(main)> p = Post.last
  Post Load (5.6ms)  SELECT "posts".* FROM "posts" ORDER BY "posts"."id" DESC LIMIT 1
=> #<Post id: 2, title: "Created in console!!!", text: "Blah, blah, blah.", created_at: "2013-10-14 11:03:33", updated_at: "2013-10-14 11:03:33">

In post:
has_many :comments
has_many is a method inherited from ActiveRecord::Base

In comment:
belongs_to :post

to see those ruby changes in pry when you've been running pry, do:
[3] pry(main)> reload!
Reloading...
=> true

[25] pry(main)> c = Comment.new :text => "This is a comment"
=> #<Comment id: nil, post_id: nil, text: "This is a comment", created_at: nil, updated_at: nil>
[26] pry(main)> p.comments << c
   (0.2ms)  BEGIN
  SQL (28.3ms)  INSERT INTO "comments" ("created_at", "post_id", "text", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["created_at", Mon, 14 Oct 2013 12:17:44 UTC +00:00], ["post_id", 2], ["text", "This is a comment"], ["updated_at", Mon, 14 Oct 2013 12:17:44 UTC +00:00]]
   (2.6ms)  COMMIT
=> [#<Comment id: 1, post_id: 2, text: "This is a comment", created_at: "2013-10-14 12:17:44", updated_at: "2013-10-14 12:17:44">]
[27] pry(main)> Comment.count
   (2.9ms)  SELECT COUNT(*) FROM "comments" 
=> 1

views folder
-- comments, layouts (default is always application.html.erb), posts
convention in rails to add extension for all the things that the file be converted to: application.html.erb means that that erb will be converted to html

Rails has lots of helpers:
------------------------------------
<% @posts.each do |post| %>
  <h2><%= link_to post.title, post %></h2> # link_to is Rails helper for the <a> tag; post.title is the text to show, post is where it should link to (which Rails will figure out)
  <p>
    posted <%= time_ago_in_words post.created_at %>,
    word count: <%= number_to_human post.word_count, precision: 1 %>, # same as :precision => 1
    comments: <%= number_to_human post.comment_count %>
  </p>
  <p><%= truncate post.text, :length => 200 %></p> # same as length: 200
<% end %>

a lot of the magic paths are created by config/routes.rb:
➜  my_first_rails_app git:(w3d1-maloneyl) ✗ bundle exec rake routes
post_comments POST   /posts/:post_id/comments(.:format) comments#create
        posts GET    /posts(.:format)                   posts#index
              POST   /posts(.:format)                   posts#create
     new_post GET    /posts/new(.:format)               posts#new
    edit_post GET    /posts/:id/edit(.:format)          posts#edit
         post GET    /posts/:id(.:format)               posts#show
              PUT    /posts/:id(.:format)               posts#update
              DELETE /posts/:id(.:format)               posts#destroy
if you stick to Rails conventions, you get all these resources
you can do something similar to the above in your routes.rb if you want to redefine some stuff

BUNDLER

bundle exec...
-> bundle defines current scope/boundary of the project

you can create aliases in your .zshrc (in ~/.zshrc) 
to avoid typing "bundle exec" all the time, because we'll need "bundle exec rails s" and "bundle exec rails c" all the time anyway

rails s OR rails server -> launch server
rails c OR rails console -> launch console
rails g OR rails generator -> view all generators available (e.g. controller, model, scaffold)

if you have more versions of rails on your machine and you don't want to start a new file with the default version, you have to specify it (rails _version_ new… instead of rails new…)
rails _3.2.14_ new blog_app

Gemfile
there are many dependencies in rails
you don't need to open up Genfile.lock, but if you're curious, take a look, but don't edit
everything that's an action-something or active-something is a dependency in rails
each gem might need another gem and a very specific version at that
bundler manages all the dependencies for you automatically, getting all the right versions
you'll need to run 'bundle exec' when you have more than one version of rails
'~> 3.2.3' means from 3.2.1 to 3.2.X is ok

version number:
3.2.14020.rc1
major version (3), minor (2), patch level (14020), release (rc1)

Gemfile
groups
-- development
-- test
-- production
-- assets (e.g. css, javacsript)

every time you modify the gemfile, you have to run bundle. so after we've put pry-rails in our gem file's development bit, do:
➜  blog_app git:(w3d1-maloneyl) ✗ bundle exec rails console
Loading development environment (Rails 3.2.14)
[1] pry(main)> 
now we're in pry instead of irb!


RAKE

built by Jim Weirich
a task manager
rake db:migrate: one of the tasks of rake
rake -T -> lists all rake

➜  blog_app git:(w3d1-maloneyl) ✗ rake routes
    posts GET    /posts(.:format)          posts#index
          POST   /posts(.:format)          posts#create
 new_post GET    /posts/new(.:format)      posts#new
edit_post GET    /posts/:id/edit(.:format) posts#edit
     post GET    /posts/:id(.:format)      posts#show
          PUT    /posts/:id(.:format)      posts#update
          DELETE /posts/:id(.:format)      posts#destroy

1st column: Rails method we can use later
2nd column: HTTP verbs
4th: controller

MVC, migration (tells SQL what to do)

➜  blog_app git:(w3d1-maloneyl) ✗ bundle exec rails console
Loading development environment (Rails 3.2.14)
irb(main):001:0> 
Rails:: (then tab then y)
-> gives you all the modules of Rails

when we create a scaffold, models are created, e.g. Post
irb(main):003:0> Post
=> Post(id: integer, title: string, content: text, created_at: datetime, updated_at: datetime)

in app > views > layouts > application.html.erb, you can see that it adds stylesheet_link_tag and javascript_include_tag for you already, and you can find them under app > assets 
and as long as you keep it under the same tree/folder, any new CSS within the folder will be automatically linked too!

the scaffold gave you a bunch of stuff in posts too

_form: conventional naming of a form you'll use/render in different places
_form is a piece of a template, a partial
anything that is a partial should be named like _this

form_for
label
text_field
text_area
submit
-> and it's a form!!

journey of stuff that rails does for you when you ask for posts/new:
posts/new => routes.rb => posts_controller (def new…end) => Post.rb => posts/new.html.erb

if Rails recognizes that the @post is an empty instance, it will then do:
  form_for action = posts, class = new_post, method = post
if Rails sees @post to be an instance with stuff in the database, it will render:
  form_for action = posts/[id], class = edit_post_[id], method = post

you see stuff in your console because rails prints params by default (which we had to explicitly code in Sinatra)

all the form fields you can have in html have a ruby form helper -- just google

stuff you can do with Rails:
[2] pry(main)> 3.minutes.ago
=> Mon, 14 Oct 2013 15:19:05 UTC +00:00
[3] pry(main)> Date.tomorrow
=> Tue, 15 Oct 2013
[4] pry(main)> Date.yesterday
=> Sun, 13 Oct 2013
[5] pry(main)> Date.today + 10.days
=> Thu, 24 Oct 2013
[6] pry(main)> Date.today + 10.days + 10.years
=> Tue, 24 Oct 2023
[7] pry(main)> ["a book", "a smartphone", "a desk", "a car"].to_sentence
=> "a book, a smartphone, a desk, and a car"
[8] pry(main)> "baloney".titleize
=> "Baloney"
[9] pry(main)> "a_strong_not_in_camel_case".camelize
=> "AStrongNotInCamelCase"
[10] pry(main)> "a_strong_not_in_camel_case".camelize.underscore
=> "a_strong_not_in_camel_case"
