require "sinatra"
require "sinatra/contrib/all"
require "sinatra/reloader"
require "pg"
require "pry"
require_relative "./model/movie.rb"
also_reload "./model/movie.rb"
# Configuration
before do
  @db = PG.connect(dbname: "movies", host: "localhost")
  @movie = Movie.new(@db)
end

after do
  @db.close
end

# Routes Handlers
get "/" do
  @movies = @movie.all
  erb :index
end

get "/movies/:movie_id" do
  @movie = @movie.find params[:movie_id]
  erb :show
end

get "/new" do
  @movie = {}
  erb :new
end

post "/new" do 
   new_created_id = @movie.create params
   redirect "/movies/#{new_created_id}"
end

post "/search" do
  @movies = @movie.search params[:query]
  erb :index
end
 
get "/movies/:movie_id/update" do
  @movie = @movie.find params[:movie_id]
  erb :new
end

post "/movies/:movie_id/update" do
  @movie.update params
  redirect "/movies/#{params[:movie_id]}"
end

post "/movies/:movie_id/delete" do
  @movie.delete params[:movie_id]
  redirect "/"
end