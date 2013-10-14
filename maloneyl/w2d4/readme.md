COMMENTS AND QUESTIONS AFTER HOMEWORK
======================================

- HTML lets you run bad code... Discovered that <h4>Actors Index</h3> would give you an <h3>, "value"something" (i.e. missing the "=") will still run (but not work, of course), etc. 

- Took me some time to remember how to print the first and last names of an actor:

      From: /Users/Maloney/Development/WDI_LDN_3_Work/maloneyl/w2d4/homework/movies_app_actors_ed/main.rb @ line 25 self.GET /actors/:actor_id:

          20:   db = PG.connect(dbname: "movies", host: "localhost")
          21:   begin
          22:     actor_id = params[:actor_id].to_i
          23:     sql = "SELECT * FROM actors WHERE id = #{actor_id}"
          24:     @actor = db.exec(sql).first # return array with only one value
       => 25:     binding.pry
          26:   ensure
          27:     db.close
          28:   end
          29:   erb :show_actor
          30: end

      [1] pry(#<Sinatra::Application>)> @actor
      => {"id"=>"1",
       "first_name"=>"Jon",
       "last_name"=>"Heder",
       "dob"=>"1977-10-26",
       "image_url"=>
        "http://upload.wikimedia.org/wikipedia/commons/7/7c/Jon_Heder_by_Gage_Skidmore.jpg"}
      [2] pry(#<Sinatra::Application>)> @actor["first_name"]
      => "Jon"
      [3] pry(#<Sinatra::Application>)> @actor["first_name"] @actor["last_name"] 
      SyntaxError: unexpected tIVAR, expecting end-of-input
      @actor["first_name"] @actor["last_name"]
                                 ^
      [3] pry(#<Sinatra::Application>)> @actor["first_name"], @actor["last_name"] 
      SyntaxError: unexpected '\n', expecting '='
      [3] pry(#<Sinatra::Application>)> @actor["first_name", "last_name"] 
      ArgumentError: wrong number of arguments (2 for 1)
      from (pry):5:in `[]'
      [4] pry(#<Sinatra::Application>)> @actor["first_name"] + @actor["last_name"]
      => "JonHeder"
      [5] pry(#<Sinatra::Application>)> @actor["first_name"].@actor["last_name"].join(" ")
      SyntaxError: unexpected tIVAR, expecting '('
      @actor["first_name"].@actor["last_name"].join(" ")
                                 ^
      [5] pry(#<Sinatra::Application>)> @actor["first_name"] + " " + @actor["last_name"]
      => "Jon Heder"

- Googled how to use OR in SQL to make the search function work for movie title, first name and last name

- All good :) Just ran into stupid syntax errors and typos that could be figured out

- Asked Gerry how to accommodate single quotes so that I could do updates like "The King's Speech" and "Harry Potter and the Scocerer's Stone" and incorporated that in this app

HOMEWORK ASSIGNMENT
********************

# W2D4 Movie App Homework

## Assignment

The aim of this homework is to expand the capabilities of the movie app we built in class. In addition to storing movies in the DB, we now also want to store actors.

Your mission, should you choose to accept it, is to add an actors table to the DB. We want users to be able to perform the same CRUD actions (Create, Read, Update, Delete) that they can already perform for movies. More specifically, the users should be able to:

* list all actors in the DB
* filter the list by entering a search term
* show detailed info for a particular actor
* create a new actor in the DB
* delete an actor from the DB

Information we want to store about actors includes:

* first_name
* last_name
* dob (date of birth)
* image_url (a link to an image of the actor)

## Context

Once we can perform CRUD for both actors and movies, we'll be ready to explore how we can use DB records in combination with each other. We'll explore this later in class, but by all means have a think about how this might work in practice. For instance, it would be cool if we can associate actors with the movies they've performed in and then let users see the following:

* all the movies an actor has starred in
* all the actors who have starred in a particular movie


CLASS NOTES
============

0. HOMEWORK REVIEW
*******************

when using pry:
next -> skip a line
finish -> go back to the layer of your own code if you're in some other, e.g. Sinatra

<%= %>
-> the "=" means to print that stuff

<% %>
-> you can have ruby code without the "=" to NOT print stuff

usage:
<% if @result != nil %>
Your BMI is @result
<% else %>
stuff here
<% end %>


1. SINATRA AND DATABASES
***************************

➜  movies_app git:(w2d4-maloneyl) ✗ createdb movies
➜  movies_app git:(w2d4-maloneyl) ✗ psql -d movies -f sql/dump.sql
➜  movies_app git:(w2d4-maloneyl) ✗ psql
Maloney=# \c movies
movies=# SELECT * FROM movies;

***************
require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'

get "/" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    sql = "SELECT * FROM movies" # pg gem will add semi-colons automatically
    @movies = db.exec(sql)
  ensure
    db.close
  end
  erb :index
end
***************

remember, <% %> just means using ruby code in your erb
<%= %> means DISPLAY this stuff too

<% @movies.each do |movie| %>
  <%= movie %>
<% end %>

------

<ul>
  <% @movies.each do |movie| %>
    <li>
      <h4>
        <a href="/movies/<%= movie["id"]%>">
          <%= "#{movie["title"]} (#{movie["year"]})" %>
        </a>
      </h4>
    </li>
  <% end %>
</ul>

----


post "/search" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    query_string = params[:query]
    sql = "SELECT * FROM movies WHERE title ILIKE '%#{query_string}%'" # ILIKE makes it case-insensitive
    @movies = db.exec(sql)
  ensure
    db.close
  end
  erb :index 
end

------

input type="number" 
^-- works in HTML5, not earlier versions

CRUD: create read update delete
REST: representational state transfer -> http verbs: get, post, delete, put (update)
