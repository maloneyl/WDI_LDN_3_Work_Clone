require "sinatra"
require "sinatra/contrib/all"
require "sinatra/reloader"
require "pg"
require "pry"

require_relative "./model/movie.rb" # Ruby knows you're requiring an .rb file so will just look for one with that file type
also_reload "./model/movie.rb"

before do
  @db = PG.connect(dbname: "movies", host: "localhost")
  @movie = Movie.new(@db)
end

after do
  @db.close
end

get "/" do
  @movies = @movie.all
  erb :index
end

get "/movies/:movie_id" do
  @movie = @movie.find(params[:movie_id])
  erb :show
end

get "/new" do
  @movie = {}
  erb :new
end

post "/new" do
  new_created_id = @movie.create(params) # params is that hash that Sinatra gives you!
  redirect "/movies/#{new_created_id}"
end

post "/search" do
  @movies = @movie.search(params[:query])
  erb :index
end

get "/movies/:movie_id/update" do
  @movie = @movie.find(params[:movie_id])
  erb :new
end

post "/movies/:movie_id/update" do
  @movie.update(params) # no need to assign it to @movie here because we don't need the value aftter
  redirect "/movies/#{params[:movie_id]}"
end

post "/movies/:movie_id/delete" do
  @movie.delete(params[:movie_id])
  redirect "/"
end



















