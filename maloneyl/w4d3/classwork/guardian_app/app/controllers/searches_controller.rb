class SearchesController < ApplicationController

  def create
    @search = Search.new(params[:query])
    render :index
  end

  # ADVANCED SEARCH:
  # def create
  #   query_terms = params[:query].split.join("|") # .split without argument means split at white space
  #   # query_terms = params[:query].gsub(" ", "|")
  #   @posts = Post.advanced_search(query_terms)
  #   render :index
  # end

  # BASIC SEARCH:
  # def create
  #   @posts = Post.basic_search(params[:query])
  #   render :index
  # end

end
