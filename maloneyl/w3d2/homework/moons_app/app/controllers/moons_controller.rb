class MoonsController < ApplicationController

  def index
    @moons = Moon.all
  end

  def new
    @moon = Moon.new # this @moon is needed purely to communicate with the view; ruby will garbage-collect eventually
  end

  def create # this is not actually a page so no create.html.erb; it's only used by the form 
    # we don't need @moon here because it doesn't have to communicate with another view
    moon = Moon.new params[:moon] # params[:moon], not params[:field_names]!
    moon.save
    redirect_to moons_url
    # going to the show page would be better (redirect_to moon), but if we don't have that yet, go to index
    # 'render :index' means to render its VIEW only, not to execute the index METHOD where you'd get @moons = Moon.all
    # '_url' must be used instead of '_path' when using 'redirect_to'
  end

end