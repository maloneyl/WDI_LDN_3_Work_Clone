class RatesController < ApplicationController

  respond_to :html, :json # i.e. can render html or json
  # when we go to /rates, /rates.html is the default
  # if you use rails generate to generate a model, these format options are included in our methods

  def index
    rates = Rate # won't use it in the template, so doesn't need to be @rates
    rates = rates.offset(params[:offset].to_i) if params[:offset] # we have this params because of our .getJSON function's {offset: offset}
    rates = rates.limit(100) # always render 100 results only
    respond_with rates # i.e. also respond_to :html, :json
  end

end
