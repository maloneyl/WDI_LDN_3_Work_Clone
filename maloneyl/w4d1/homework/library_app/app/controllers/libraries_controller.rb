class LibrariesController < ApplicationController

  def index
    @libraries = Library.all
  end

  def new
    @library = Library.new
  end

  def create
    @library = Library.new params[:library]
    if @library.save
      redirect_to @library
    else
      render :new
    end
  end

  def show
    @library = Library.find params[:id]
  end

  def edit
    @library = Library.find params[:id]
  end

  def update
    @library = Library.find params[:id]
    if params[:bookshelf_id]
      @library.bookshelves << Bookshelf.find(params[:bookshelf_id])
      @library.save
    else
      @library.update_attributes params[:library]
    end
    redirect_to @library
  end

  def destroy
    library = Library.find params[:id]
    library.delete
    redirect_to libraries_path
  end

end
