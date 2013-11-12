class GdpsController < ApplicationController

  respond_to :html, :json

  def index
    gdps = Gdp
    gdps = gdps.offset(params[:offset].to_i) if params[:offset]
    gdps = gdps.limit(100)
    respond_with gdps
  end

end
