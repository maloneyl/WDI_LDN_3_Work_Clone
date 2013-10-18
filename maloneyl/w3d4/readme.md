QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

- YAY for no homework for a change! Good to sleep more :)


CLASS NOTES
============

add another form under the original add/edit form, and put this new form under the edit view

then in actors_controller:
-----------------
  def update  
    actor = Actor.find params[:id]
    # if the second form (actor) is submitted, push that movie into the actor.movies array
    if params[:movie_id]
      actor.movies << Movie.find(params[:movie_id])
      actor.save
      # movie = Movie.find(params[:movie_id]) -- this is just saving the other way around
      # movie.actors << actor -- (cont'd above)
    else 
      actor.update_attributes params[:actor]
      # update_attributes includes save already, so we don't need to to actor.save here
    end
    redirect_to actor
  end
---------------

.
.
.

need to show full name? DEFINE YOUR OWN FULL_NAME METHOD IN THE MODEL! ….why didn't I think of that :(
in actor.rb:
--------
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
---------
so now on that additional form we put on the edit movie page, we can do:
<fieldset>
  <legend>Add an actor/actress</legend>
  <%= form_for(@movie) do |f| %>
    <%= select_tag 'actor_id',
        options_from_collection_for_select(@actors, 'id', 'full_name') %>
<!--     3 arguments are: where it's populating from, field for value, field for text to display from -->
<!--     full_name works here because we have a full_name method ( "#{self.first_name} #{self.last_name}") defined in Actor class now! -->
    <%= f.submit %>
  <% end %>
</fieldset>

and the movies_controller.rb is now:
----
  def edit
    @movie = Movie.find params[:id]
    @actors = Actor.all # for that "add an actor" dropdown
  end

  def update  
    movie = Movie.find params[:id]
    # if params[:actor_id] has been passed, that means we want to add an actor
    if params[:actor_id]
      movie.actors << Actor.find(params[:actor_id])
      movie.save
    # otherwise, if there's no actor_id params passed, it's just a regular update
    else 
      movie.update_attributes params[:movie]
    # reminder: update_attributes includes save, so no need to do movie.save here     
    end
    redirect_to movie
  end
-----

To be able to seed the join table too, make sure to use variables so that you can do things like
movie1 = Movie.create!(...)
actor1 = Actor.create!(...)
actor1.movies = [movie1, movie2]
actor1.save
movie1.actors << actor1
REMEMBER: we are adding stuff to an ARRAY so we need to either '= []' or '<<'

to re-seed, put .delete_all at the top
Movie.delete_all
Actor.delete_all


1. HAML
************

Haml (HTML Abstraction Markup Language) is a faster way to do HTML

match '/' => 'home#index'
# match: get, post, etc. to be handled by the index action/method of the home controller

a directory per controller, 
a views folder per controller, under which is a file per action (index, edit, etc.)

app > stylesheets > styles.css
is where you should save your stylesheet to be used as default automagically

forward-slash to comment; not same line as code though
recreating old_index.html.erb in haml
indenting matters even more here because there's no opening and closing things in haml!
you just do %[element], e.g. %div to create a div
indenting is what decides whether one div is inside another, etc.

%div#div_1
  %p
    DIV 1 FROM HAML
  %div#div_2
    DIV 2
  %div#div_3.text-right
    DIV 3
    %p
      = @text
%div#div_4
  DIV 4
  - if @text == "y u no"
    %p
      = @text.upcase
  - 7.times do |number|
    %p= number 

forward-slash to comment; not same line as code though
it could also mess up your indenting/nesting….so be careful

% indicates an html tag, both opening and closing
that's right - that's no closing things in haml!
that's why indenting matters even more here

you just do %[element], e.g. %div to create a div

indenting is what decides whether one div is inside another, etc.

use the same amount of space for each indent

create a div element and assign the id div_1:
you can use this shortcut for divs: #div_1 (div id alone is enough if it's a div)
and you can also add a class: element#id.class
and again, for a div, you can just shortcut to #id.class
basically, if you don't specify the element, haml will default to div

the - is the equivalent of <% %>
the = is the equivalent of <%= %>
what if you want to print the "="? escape it with "\="
e.g.
------
%div#div_4
  DIV 4
  - my_day = "Thursday"
  /no output ^
  - if @text == "y u no"
    %p
      = @text.upcase
      Something else
      = my_day
      \= 4
------

you can have views in haml, erb, html formats within an app

and again, spacing matters!
%p= number IS NOT THE SAME AS %p = number
%p= number means print on each paragraph the value of the variable number
%p = number means print on each paragraph the word 'number'

forms work similarly:
just note that you need to pass a hash to the form, input and option tags
it doesn't really matter whether you pass the value as a symbol or a string
the resulting params will make it a string anyway
---------
      %div#content
        %form{action: '/postform', method: 'post'}
          %input{name: 'name', placeholder: 'Name', type: 'text'}
          %input{name: 'email', placeholder: 'Email', type: 'text'}
          %label Sex
          %select
            %option{value: 'f'} Female
            %option{value: 'm'} Male
----------
IS THE SAME AS
----------
      <div id='content'>
        <form action='/postform' method='post'>
          <input name='name' placeholder='Name' type='text'>
          <input name='email' placeholder='Email' type='text'>
          <label>Sex</label>
          <select>
            <option value='f'>Female</option>
            <option value='m'>Male</option>
          </select>
        </form>
      </div>
----------


2. SASS
************
Syntactically Awesome Stylesheets

Haml for CSS!
invented by the same guy

also can handle stuff that can't be done in plain CSS, e.g. mix-ins and inheritance

file extension is .scss

SCSS = sassy CSS!
we are learning to write in the SCSS syntax
there is a SASS syntax too

valid CSS is valid SCSS
you can name your file .scss and when you visit /filename.css, you'll see that file translated line by line

you can declare variables in SCSS!
------------
$text-color: orange; /* declaring a variable!*/

div {
  color: $text-color;
}
------

you can nest a lot of stuff!
------
#footer {
  color: $text-color;

  p {
    color: yellow;

    &.very-big {
      font-size: 20px;
    }

    .so-small {
      font-size: 5px;
    }

  }
}
-----
&.very-big: p element with very-big class in the footer (this translates to CSS as #footer p.very-big
)
.so-small: without the &, it refers to a child element instead of the same element; it means any element with the so-small class that's inside a p element that's inside of footer (this translates to CSS as #footer p .so-small)

another example:
    &#date {
      color: COLOR-DATE;
    }
translates to CSS as "#footer p#date"
again, means that parent class with the id 'date'

a use case could be to do 3 social media buttons, where the icons are the background images
e.g. (the below works but not the best approach):
-----
ul.social-buttons {
  li {
    padding: 20px;
  }
  li.twitter {
    background-image: twitter;
  }
  li.fb {
    background-image: facebook;
  }  
  li.gplus {
    background-image: gplus;
  }  
}
----
but a better approach would be:
ul.social-buttons {
  li {
    padding: 20px;
  
    &.twitter {
    background-image: twitter;
    }

    &.fb {
      background-image: facebook;
    }

    &.gplus {
    background-image: gplus;
    }  
  }  
}

another DRY feature thanks to SCSS
you can do CSS declarations just once and then pass the whole set of declaration
e.g. for CSS3 border-radius you have to declare for multiple browsers:
@mixin border-radius($radius) {
  -webkit-border-radius: $radius; 
  -moz-border-radius: $radius;
  border-radius: $radius;
} 

#footer {
  @include border-radius(25px);
}
BECOMES TRANSLATED AS
#footer {
  -webkit-border-radius: 25px;
  -moz-border-radius: 25px;
  border-radius: 25px;
}

and add another mix-in and edit the footer
@mixin centered-text($color) {
  text-align: center;
  color: $color;
  }
#footer {
  @include border-radius(25px);
  @include centered-text(yellow);
}
BECOMES TRANSLATED AS
#footer {
  -webkit-border-radius: 25px;
  -moz-border-radius: 25px;
  border-radius: 25px;
  text-align: center;
  color: yellow;
}

and since we've already defined for $text-color as yellow in this SCSS example, let's change that to:
  @include centered-text($text-color);  
because we can!

you can also do extend (with a class):
.text-red {
  color: red;
}

.footer-text {
  @extend .text-red;
}

you can mix-in mix-ins and extend extends

you might want to first structure the SCSS with all the elements so you can nest things in properly first (all structure, no declarations), then look into what can be reused
