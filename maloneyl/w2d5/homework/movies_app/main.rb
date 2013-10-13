require "sinatra"
require "sinatra/contrib/all"
require "sinatra/reloader"
require "pg"
require "pry"

require_relative "./model/movie.rb"
require_relative "./model/actor.rb"
also_reload "./model/movie.rb"
also_reload "./model/actor.rb"

before do
  @db = PG.connect(dbname: "movies", host: "localhost")
  @movie = Movie.new(@db)
  @actor = Actor.new(@db)
end

after do
  @db.close
end

get "/" do
  @movies = @movie.all
  @actors = @actor.all
  erb :index
end

post "/search" do
  @movies = @movie.search(params[:query])
  @actors = @actor.search(params[:query])
  erb :index
end

get "/movies/:movie_id" do
  @stars = @movie.actor(params[:movie_id]) # this must come first; otherwise it's undefined method for the resulting hash. not 100% getting it...
  @movie = @movie.find(params[:movie_id])
  binding.pry
  erb :show_movie
end

get "/actors/:actor_id" do
  @films = @actor.movie(params[:actor_id])
  @actor = @actor.find(params[:actor_id])
  erb :show_actor
end

get "/new/movie" do
  @movie = {}
  erb :new_movie
end

post "/new/movie" do
  new_created_id = @movie.create(params) # params is that hash that Sinatra gives you!
  redirect "/movies/#{new_created_id}"
end

get "/new/actor" do
  @actor = {}
  erb :new_actor
end

post "/new/actor" do
  new_created_id = @actor.create(params) # params is that hash that Sinatra gives you!
  redirect "/actors/#{new_created_id}"
end

get "/movies/:movie_id/update" do
  @movie = @movie.find(params[:movie_id])
  erb :new_movie
end

post "/movies/:movie_id/update" do
  @movie.update(params) # no need to assign it to @movie here because we don't need the value aftter
  redirect "/movies/#{params[:movie_id]}"
end

get "/actors/:actor_id/update" do
  @actor = @actor.find(params[:actor_id])
  erb :new_actor
end

post "/actors/:actor_id/update" do
  @actor.update(params) # no need to assign it to @movie here because we don't need the value aftter
  redirect "/actors/#{params[:actor_id]}"
end

post "/movies/:movie_id/delete" do
  @movie.delete(params[:movie_id])
  redirect "/"
end

post "/actors/:actor_id/delete" do
  @actor.delete(params[:actor_id])
  redirect "/"
end

















