class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new params[:book]
    if @book.save
      redirect_to @book
    else
      render :new
    end
  end

  def show
    @book = Book.find params[:id]
  end

  def edit
    @book = Book.find params[:id]
  end

  def update
    @book = Book.find params[:id]
    if params[:bookshelf_id]
      @book.bookshelf_id = params[:bookshelf_id].to_i # assumes only one copy of the book and can only be on one bookshelf
      @book.save
    else
      @book.update_attributes params[:book]
    end
    redirect_to @book
  end

  # def update
  #   @book = Book.find params[:id]
  #   if params[:bookshelf_id]
  #     @bookshelf = Bookshelf.find(params[:bookshelf_id])
  #     @bookshelf.books << @book
  #     @bookshelf.save
  #   else
  #     @book.update_attributes params[:book]
  #   end
  #   redirect_to @book
  # end

  def destroy
    book = Book.find params[:id]
    book.delete
    redirect_to books_path
  end

end
