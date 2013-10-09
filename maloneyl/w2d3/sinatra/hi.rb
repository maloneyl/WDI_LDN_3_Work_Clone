require 'sinatra'
require 'sinatra/contrib/all'

enable :sessions

get "/" do
  p params
  "This is the homepage"
end

get "/hi" do 
  "Hello, world"
end

get "/firstname/:param_firstname" do
  "Hello, #{params[:param_firstname]}"
end

get "/name/:first/:last/:age" do
  "Your name is #{params[:first]} #{params[:last]}. Your age is #{params[:age]}."
end

get "/multiply/:x/:y" do
  @result = params[:x].to_f * params[:y].to_f
  erb :calc
end

get "/calc" do
  erb :calc
end

post "/calc" do
  session["calc_count"] = 0 unless session["calc_count"]
# if there's no calc_count initiated yet, set it to 0
  session["calc_count"] += 1
  operator = params[:operator]
  first_number = params[:first_number].to_f
  second_number = params[:second_number].to_f
  @calc_count = session["calc_count"]
  @result = case operator
  when "+" then first_number + second_number
  when "-" then first_number - second_number
  when "x" then first_number * second_number
  when "/" then first_number / second_number
  end
  erb :calc
end

get "/about" do
  @name = "Baloney"
  @job = "Tweeter"
  erb :about
end
