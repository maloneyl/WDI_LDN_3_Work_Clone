QUESTIONS AND COMMENTS AFTER HOMEWORK
=======================================

OK for the most, but realizing that I'm not very good with CSS yet, especially positiong and floating and all that stuff.

Also wondering how to treat line breaks for the directions. What if we want to store paragraphs?


*********
HOMEWORK
*********

CookBook App
 
You’ve been tasked with creating a Rails app that models a common cookbook's behaviour. It should allow users to create and look at recipes, as well as see ingredients needed and cooking directions. 

Your app should have at least a Recipe model with its CRUD actions, and an Ingredient model with its CRUD actions.
 
Remember: an individual Recipe can have lots of Ingredients, and an Ingredient can be used in lots of Recipes, so you need to determine the database structure that supports this.
 
Make sure you’re also practicing your newly acquired styling skills, and make your app look pretty!

We’re not doing anything new in this homework - this weekend is all about practice, and repetition, repetition, repetition. We want to see working code on Monday! 



CLASS NOTES
============

1. RAILS: PARTIALS, LAYOUTS
***************************************

DB shortcuts:
  • drop
  • setup (which does these 3 things in 1 command: create, migrate, seed)

expanding the movies_actors_app:
you can create partials for other stuff than just the form
but you'll have to mindful about passing any local variables in the originating view to that partial


index.html.erb:
--------
<h2>All Movies</h2>

<ul>
  <% @movies.each do |movie| %>
    <%= render 'movie', locals: { movie_variable: movie } %> 
    <!-- pass that |movie| local variable -->
    <!-- syntax is: locals: { key: value }  -->
    <!-- where value is that local variable -->
  <% end %>
</ul>  
--------
_movie.html.erb:
-------
<li><strong><%= link_to movie_variable.title, movie_path(movie_variable) %></strong><br />
  (Released: <%= movie.release_date.to_formatted_s(:rfc822) %>)</li>  
-------


BUT rails is smart!
if you name your partial the same name as your model, rails will look for that partial and render it
you can instead just do:
-------index-----------
<h2>All Movies</h2>

<ul>
  <% @movies.each do |movie| %>
    <%= render movie %>
  <% end %>
</ul>  
--------/index-----------
-------_movie----------
<li><strong><%= link_to movie.title, movie_path(movie) %></strong><br />
  (Released: <%= movie.release_date.to_formatted_s(:rfc822) %>)</li>  
------/_movie----------

OR make it even simpler by editing that index's render line to: <%= render @movies %> 
because again, rails will look for things with that name...

it's good practice to do a list (or anything detailed) in a partial, then just call a simple rendering
that's so things will look cleaner (on the index/associated page) even when you need to do a lot of styling and include many items

AND YOU CAN HAVE MORE LAYOUTS!
class MoviesController < ApplicationController
  layout 'admin' # rails will then look in a views folder for a layout with that name
…
end


and you don't need to hardcode a layout in, but instead of do it with a method, e.g.
  layout which_layout
and define a which_layout method (make it private by stating private in the line above) and do whatever you want to render whatever layout because of whatever conditions (e.g. maybe you want a black background for male actors and a pink background for female actors….just to be stereotypical)

you can also render at different places within the same method,
e.g. for our update method
  def update  
    movie = Movie.find params[:id]
    if params[:actor_id]
      movie.actors << Actor.find(params[:actor_id])
      movie.save
      render :some_actor_layout_we_do_not_have_yet and return # so that it leaves the method
    else 
      movie.update_attributes params[:movie]
      render :show
    end
    redirect_to movie
  end
------
render just calls the method associated; redirect_to leaves the method and does another http request
redirect will change the url; render doesn't

and back to the layout on the top, you can do things like:
  layout "application" # default action
  layout: first_layout # refer to a method inside the controller
  layout: second_layout, only:[:create] # use a specific layout only for a specific method (create in this case)
  layout: third_layout, except:[:index] # use a specific layout except for that specific method (index in this case)

you can have more than one yield in a single page
you just need to call a specific yield.
let's say you'd like the index page to have a specific header, so you go to your application.html.erb and add:
<header>
  <%= yield :header %>
</header>
then in your movies/index.html.erb, 
<% content_for :header do %>
  Header content imported from index template
<% end %>


2. MORE ABOUT HAML
******************************

gem 'haml-rails'
-> replaces rails g scaffold's default from erb to haml

to get that installed, we'll do:
bundle install
rbenv rehash

to run two rails apps, we specify the ports to use (3000 is the default):
bundle exec rails s -p 3000
bundle exec rails s -p 3001

haml handles new-line with a space added before and after
that's why you can do:
    = link_to planet.name, planet_path(planet)
    has
    = pluralize(planet.moons, 'moon')

what if you DON'T want the white space?
> will remove all whitespace surrounding a tag, while < will remove all whitespace immediately within a tag.
example:
= link_to planet_path(planet) do
   = image_tag planet.image, class: 'thumbnail'
   %br>

you can call string interpolation without your haml ruby too:
%table
  %tr
    %th Orbit
    %td #{@planet.orbit} AU # if you need to append a unit
  %tr
    %th Moons
    %td= @planet.moons # if you don't need to append a unit
  %tr
    %th Diameter
    %td= pluralize(@planet.diameter, 'Earth Diameter') # just to be fancy with pluralizing correctly


3. MORE ABOUT SASS
******************************

sass has a lot of helpers!

you can do one color based on another:
$color-1: rgb(141, 165, 181);
$color-4: lighten($color-1, 30%); 

you can multi-file sass, similar to how you can do 'include' in ruby
but we probably won't need to deal with it

-----------
nav {
  &.nav-top {
    padding: 10px;
    border-bottom: $border-size $color-1;
    background-color: $color-4;
  }
  &.nav-bottom { margin-top: 5px }
}
-----------
one-line CSS doesn't need the semi-colon

visualizing the difference between .nav-top (A) and &.nav-top (B) above:
(A) is:
  <nav>
    <div class="nav-top"></div>
  </nav>
(B) is:
  <nav class="nav-top">
  </nav>

you generally don't want more than 3 terms in your selectors because that would slow down the browser a lot, so don't nest unnecessarily
note that in a form, legend is within fieldset in the html, in CSS you never have to, i.e. we just have .standard-form fieldset and .standard-form legend