class SearchesController < ApplicationController

  def create
    @search = Search.new(params[:query])
    render :index
  end

end