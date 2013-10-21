class BookshelvesController < ApplicationController

  def index
    @bookshelves = Bookshelf.all
  end

  def new
    @bookshelf = Bookshelf.new
  end

  def create
    @bookshelf = Bookshelf.new params[:bookshelf]
    @bookshelf.library_id = Library.where(name: 'General Library').first.id 
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
    @bookshelf = Bookshelf.find params[:id]
    if params[:book_id]
      @book = Book.find(params[:book_id].to_i)
      @book.bookshelf_id = params[:id]
      @book.save
    else
      @bookshelf.update_attributes params[:bookshelf]
    end
    redirect_to @bookshelf
  end

  def destroy
    bookshelf = Bookshelf.find params[:id]
    bookshelf.delete
    redirect_to bookshelves_path
  end

end
