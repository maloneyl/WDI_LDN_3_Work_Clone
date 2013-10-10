require 'sinatra'
require 'sinatra/contrib/all'

get "/" do
  erb :welcome
end

get "/basic" do
  @result = "_____"
  erb :basic
end

post "/basic" do
  operator = params[:operator]
  first_number = params[:first_number].to_f
  second_number = params[:second_number].to_f
  @result = case operator
  when "+" then first_number + second_number
  when "-" then first_number - second_number
  when "x" then first_number * second_number
  when "*" then first_number * second_number
  when "/" then first_number / second_number
  end
  erb :basic
end

get "/bmi" do
  @bmi = "_____"
  erb :bmi
end

post "/bmi" do
  if params[:weight_kg].empty? == false && params[:height_metres].empty? == false
    bmi = params[:weight_kg].to_f / (params[:height_metres].to_f)**2
  elsif params[:weight_lbs].empty? == false && params[:height_ft].empty? == false && params[:height_in].empty? == false
    bmi = params[:weight_lbs].to_f / ((params[:height_ft].to_f)*12 + params[:height_in].to_f)**2 * 703
  end
  @bmi = bmi.round(2)
  erb :bmi
end

get "/mortgage" do
  @monthly_payment = "_____"
  erb :mortgage
end

post "/mortgage" do
  p = params[:principal_amount].to_f
  i = params[:interest_rate].to_f / 100 / 12 # turn x% into decimal then into monthly rate
  n = params[:loan_terms].to_f * 12
  monthly_payment = p * ( i * (1 + i)**n ) / ( (1 + i)**n - 1 )
  @monthly_payment = monthly_payment.round(2) # separate from above just to be more readable
  erb :mortgage
end

get "/mileage" do
  @how_long = "_____"
  @how_much = "_____"
  erb :mileage
end

post "/mileage" do
  distance = params[:distance].to_f
  mpg = params[:mpg].to_f
  gas_price = params[:gas_price].to_f
  speed = params[:speed].to_f

  if speed > 60
    too_fast_for_mpg = speed - 60
    mpg = mpg - (too_fast_for_mpg * 2)
  end

  @how_long = (distance / speed).round(2)
  @how_much = (gas_price / mpg * distance).round(2)

  erb :mileage
end