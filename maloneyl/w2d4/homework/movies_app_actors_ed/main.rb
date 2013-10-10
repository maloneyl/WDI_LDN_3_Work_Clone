require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'pry'

get "/" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    sql = "SELECT * FROM movies" # pg gem will add semi-colons automatically
    @movies = db.exec(sql)
    sql = "SELECT * FROM actors"
    @actors = db.exec(sql)
  ensure
    db.close
  end
  erb :index
end

get "/actors/:actor_id" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    actor_id = params[:actor_id].to_i
    sql = "SELECT * FROM actors WHERE id = #{actor_id}"
    @actor = db.exec(sql).first # return array with only one value
    binding.pry
  ensure
    db.close
  end
  erb :show_actor
end

get "/movies/:movie_id" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    movie_id = params[:movie_id].to_i
    sql = "SELECT * FROM movies WHERE id = #{movie_id}" # pg gem will add semi-colons automatically
    @movie = db.exec(sql).first # return array with only one value
  ensure
    db.close
  end
  erb :show_movie
end

get "/new/actor" do
  @actor = {}
  erb :new_actor
end

post "/new/actor" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    sql = "INSERT INTO actors (first_name, last_name, dob, image_url) VALUES
      ('#{params[:first_name]}', '#{params[:last_name]}', '#{params[:dob]}', '#{params[:image_url]}') RETURNING id"
    @actor = db.exec(sql) # returns object ot type 'pg result', whose first hash is result of RETURNING id
    new_created_id = @actor[0]["id"] # up to [0] you get a hash back (id=>"X"). then you get the "X" with "id" key)
    redirect "/actors/#{new_created_id}"
  ensure
    db.close
  end  
end

get "/new/movie" do
  @movie = {}
  erb :new_movie
end

post "/new/movie" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    sql = "INSERT INTO movies (title, year, rated, poster, director, actors) VALUES ('#{params[:title]}', '#{params[:year]}', '#{params[:rated]}', '#{params[:poster]}', '#{params[:director]}', '#{params[:actors]}') RETURNING id"
    @movie = db.exec(sql) # returns object ot type 'pg result', whose first hash is result of RETURNING id
    new_created_id = @movie[0]["id"] # up to [0] you get a hash back (id=>"X"). then you get the "X" with "id" key)
    redirect "/movies/#{new_created_id}"
  ensure
    db.close
  end
end

post "/search" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    query_string = params[:query]
    sql = "SELECT * FROM movies WHERE title ILIKE '%#{query_string}%'" # ILIKE makes it case-insensitive
    @movies = db.exec(sql)
    sql = "SELECT * FROM actors WHERE first_name ILIKE '%#{query_string}%' OR last_name ILIKE '%#{query_string}%'" # ILIKE makes it case-insensitive
    @actors = db.exec(sql)    
  ensure
    db.close
  end
  erb :index 
end

post "/actors/:actor_id/delete" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    actor_id = params[:actor_id]
    sql = "DELETE FROM actors WHERE id = #{actor_id}"
    db.exec(sql)
    redirect "/"
  ensure
    db.close
  end    
end

post "/movies/:movie_id/delete" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    movie_id = params[:movie_id]
    sql = "DELETE FROM movies WHERE id = #{movie_id}"
    db.exec(sql)
    redirect "/"
  ensure
    db.close
  end    
end

get "/actors/:actor_id/update" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    actor_id = params[:actor_id]
    sql = "SELECT * FROM actors WHERE id = #{actor_id}" 
    @actor = db.exec(sql).first # return array with only one value
  ensure
    db.close
  end    
  erb :new_actor
end

post "/actors/:actor_id/update" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    actor_id = params[:actor_id].to_i
    sql = "UPDATE actors SET
      first_name = '#{params[:first_name]}',
      last_name = '#{params[:last_name]}',
      dob = '#{params[:dob]}',
      image_url = '#{params[:image_url]}'
      WHERE id = #{actor_id}"
    db.exec(sql)
    redirect "/actors/#{actor_id}"
  ensure
    db.close
  end    
end

get "/movies/:movie_id/update" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    movie_id = params[:movie_id]
    sql = "SELECT * FROM movies WHERE id = #{movie_id}" 
    @movie = db.exec(sql).first # return array with only one value
  ensure
    db.close
  end    
  erb :new_movie
end

post "/movies/:movie_id/update" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    movie_id = params[:movie_id].to_i
    sql = "UPDATE movies SET
      title = '#{db.escape params[:title]}',
      year = '#{params[:year]}',
      rated = '#{params[:rated]}',
      poster = '#{params[:poster]}', 
      director = '#{params[:director]}', 
      actors = '#{params[:actors]}'
      WHERE id = #{movie_id}"
    db.exec(sql)
    redirect "/movies/#{movie_id}"
  ensure
    db.close
  end    
end
