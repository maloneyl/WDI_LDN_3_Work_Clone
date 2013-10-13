QUESTIONS AND COMMENTS AFTER HOMEWORK
======================================

- Interesting to learn a little bit more about SQL and the join-table command.

- The official part of the homework (refactoring Actors and getting Movies to display linked Actors and vice versa) wasn't too difficult. I would've finished it earlier if not because of an 'undefined method for hash' error that held me up for maybe half an hour. Eventually I guessed/understood the error to mean that @movie = @movie.find(params[:movie_id]) can't be above my new @actors = @movie.actor(params[:movie_id]) because then @movie is a hash that can't run that .actor method. Was that the real reason? In any case, I'm glad that moving the order helped...
  
- Working in the function of adding an actor to a movie took quite a lot of time and experimentation. The function as it is does work, and I've coded it to ignore that action if the field is blank. However, I haven't quite figured out how to make the drop-down include only the actors who aren't already linked to the movie as well as what to do with the actors update or deletion. Also haven't got to adding a movie for an actor...

- Think this homework has been equal-parts rewarding and challenging.


********** HOMEWORK ****************

Following the approach we used for movies on friday morning, your task this weekend is to refactor the CRUD structure for actors .

Once this is done, create another table called "actors_movies". This table will be used to link your "actors" and "movies" tables. It should contain 3 fields : id, actor_id, movie_id.

From there on, create 2 others functions, one in the Movie class, and one in the Actor class. These new methods should allow you to return actors for a given film and movies for a given actor, respectively.

Example:

class Movie
  def actor id
    #something here
  end
end
In this example , for a given movie id, the method should return all the actors associated with said movie. To link an actor to a movie, you add a record inside actors_movies.

For example, if we have:

+----------------------+
|   actors_movies      |
+----------+-----------+
| actor_id | movie_id  |
+----------+-----------+
|    1     |    1      |
|    1     |    2      |
|    1     |    3      |
|    2     |    1      |
|    2     |    4      |
+----------+-----------+
It means the actor with an id = 1 is in the movies 1,2,3. The actor with an id = 2 is in the movies 1,4.

Let's look at this SQL statement:

SELECT * FROM actors INNER JOIN actors_movies ON actors_movies.actor_id = actors.id WHERE actors_movies.movie_id = 1
--> it will return all the actors that are in the movie 1.

Now on the movie show template, you should implement a feature that also displays the actors that were in this movie, like this:

[screenshot]

You see how a given movie also lists its actors? Go ahead, and implement a similar functionality for actor pages, which should list the movies they starred in.

***********************************


CLASS NOTES
===========


0. HOMEWORK REVIEW
*******************

num_tuples
-> return number of rows

result.num_tuples.zero?
-> basically, "are you zero"?


1. SINATRA WITH SQL
********************

get, enable, configure, before, after, etc. are Sinatra methods that we have access to with no work on our part

------------
before do
  @db = PG.connect(dbname: "movies", host: "localhost")
end
------------
now this will be available everywhere and we won't have to repeat the db = PG.connect… code in each of our own blocks

similarly, we can do that for our "ensure db.close":
--------------
after do
  @db.close
end
--------------

MVC
model view controller

our existing main.rb is doing both model and controller (ruby and sql), while the view is separate (erb)

lots of refactoring -- see classwork


2. WEEKLY REVIEW
******************

create a method, under this module, that puts a string in title case:
-------------------------
module UniversalFormatter
  def titleiz(string)
    string.split(" ").map do |word|
      word.capitalize
    end.join(" ")
  end
end


--------
class Lake
  attr_reader :name, :type
  attr_accessor :temp

  include UniversalFormatter

  def initialize(n, t, temperature)
    @name = n
    @type = t
    @temp = temperature
  end

  def describe
    puts titleiz "Lake #{name} is #{type} and is #{temp} degrees C" # these are actually method calls, not instance variables
  end
--------

if you then have a sub-class under Lake, the initialize method could be:

class Pond < Lake
  attr_accessors: num_of_frogs

  def initialize(n, t, temperature, num_of_frogs)
     super(n, t, temperature)
     @num_of_frogs = num_of_frogs
  end
