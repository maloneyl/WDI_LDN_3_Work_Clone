class PlanetsController < ApplicationController

  def index
    logger.info "about to render index..."
    @planets = Planet.order(:orbit).all
  end

  def new
    @planet = Planet.new
  end

  def create
    @planet = Planet.new params[:planet]
    @planet.save
    redirect_to @planet
  end

  def edit
    @planet = Planet.find params[:id]
  end

  def show
    @planet = Planet.find params[:id]
  end

  def update  
    @planet = Planet.find params[:id]
    @planet.update_attributes params[:planet]
    redirect_to @planet
  end

  def destroy
    @planet = Planet.find params[:id]
    @planet.destroy
    redirect_to planets_url
  end

  def do_something_stupid
    x = 100
    y = 0
    x / y
  end

end