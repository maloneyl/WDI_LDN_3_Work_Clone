require "sinatra"
require "sinatra/contrib/all"
require "pg"
require "pry"

# Configuration
# configure do
#   enable :sessions
# end

before do
  @db = PG.connect(dbname: "movies", host: "localhost")
end

after do
  @db.close
end

get "/" do
  @movies = @db.exec "SELECT * FROM movies"
  erb :index
end

get "/movies/:movie_id" do
  @movie = @db.exec("SELECT * FROM movies WHERE id = #{params[:movie_id].to_i}").first
  erb :show
end

get "/new" do
  @movie = {}
  erb :new
end

post "/new" do
  new_created_id = @db.exec("INSERT INTO movies (title, year, rated, poster, director, actors)
    VALUES ('#{params[:title]}', '#{params[:year]}', '#{params[:rated]}', '#{params[:poster]}', '#{params[:director]}', '#{params[:actors]}') RETURNING id")[0]["id"]
  redirect "/movies/#{new_created_id}"
end

post "/search" do
  @movies = @db.exec "SELECT * FROM movies WHERE title ILIKE '%#{params[:query]}%'"
  erb :index
end

get "/movies/:movie_id/update" do
  @movie = @db.exec("SELECT * FROM movies WHERE id = #{params[:movie_id]}").first
  erb :new
end

post "/movies/:movie_id/update" do
  movie_id = params[:movie_id].to_i
  @db.exec "UPDATE movies SET
     title = '#{params[:title]}',
     year = '#{params[:year]}',
     rated = '#{params[:rated]}', 
     poster = '#{params[:poster]}',
     director = '#{params[:director]}', 
     actors = '#{params[:actors]}' 
     WHERE id = #{movie_id}"
  redirect "/movies/#{movie_id}"
end

post "/movies/:movie_id/delete" do
  @db.exec "DELETE FROM movies WHERE id = #{params[:movie_id]}"
  redirect "/"
end



















