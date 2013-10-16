class MoonsController < ApplicationController

  def index
    @moons = Moon.all
  end

  def new
    @moon = Moon.new
  end

  def create
    @moon = Moon.new params[:name], params[:associated_planet], params[:image], params[:diameter].to_f
  end

end