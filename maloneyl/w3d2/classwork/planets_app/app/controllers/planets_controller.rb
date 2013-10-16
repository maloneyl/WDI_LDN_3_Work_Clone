class PlanetsController < ApplicationController

  def index
    @planets = Planet.all
  end

  def new # that page with the form
    @planet = Planet.new # initialize one to use in view
  end

  def create # what the form does
    planet = Planet.new params[:planet] # no @ needed because there's no create view needed
    planet.save
    redirect_to planets_url
  end

  def show
    @planet = Planet.find params[:id]
  end

  def destroy
    Planet.find(params[:id]).destroy
    redirect_to planets_url
  end

  def edit # that page with the form
    @planet = Planet.find params[:id] 
  end

  def update # what the form does
    planet = Planet.find params[:id] # again, no @ needed if there's no view that needs to use this
    planet.update_attributes params[:planet]
    redirect_to planet
  end

end
