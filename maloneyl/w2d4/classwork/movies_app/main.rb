require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'

get "/" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    sql = "SELECT * FROM movies" # pg gem will add semi-colons automatically
    @movies = db.exec(sql)
    p @movies
  ensure
    db.close
  end
  erb :index
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
  erb :show
end

get "/new" do
  @movie = {}
  erb :new
end

post "/new" do
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
  ensure
    db.close
  end
  erb :index 
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

get "/movies/:movie_id/update" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    movie_id = params[:movie_id]
    sql = "SELECT * FROM movies WHERE id = #{movie_id}" 
    @movie = db.exec(sql).first # return array with only one value
  ensure
    db.close
  end    
  erb :new
end

post "/movies/:movie_id/update" do
  db = PG.connect(dbname: "movies", host: "localhost")
  begin
    movie_id = params[:movie_id].to_i
    sql = "UPDATE movies SET
      title = '#{params[:title]}',
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
