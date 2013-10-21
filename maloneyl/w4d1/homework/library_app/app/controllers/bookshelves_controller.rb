class BookshelvesController < ApplicationController

  def index
    @bookshelves = Bookshelf.all
  end

  def new
    @bookshelf = Bookshelf.new
  end

  def create
    @bookshelf = Bookshelf.new params[:bookshelf]
    if @bookshelf.save
      redirect_to @bookshelf
    else
      render :new
    end
  end

  def show
    @bookshelf = Bookshelf.find params[:id]
  end

  def edit
    @bookshelf = Bookshelf.find params[:id]
  end

  def update
    bookshelf = Bookshelf.find params[:id]
    bookshelf.update_attributes params[:bookshelf]
    redirect_to bookshelf
  end

  def destroy
    bookshelf = Bookshelf.find params[:id]
    bookshelf.delete
    redirect_to bookshelves_path
  end

end
