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


