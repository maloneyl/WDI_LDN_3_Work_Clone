class GalleriesController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :fetch_gallery, only: [:show, :edit, :update, :destroy]

  # GET /galleries
  def index
    @galleries = Gallery.all
  end

  # GET /galleries/1
  def show
  end

  # GET /galleries/new
  def new
    @gallery = Gallery.new
    3.times { @gallery.paintings.build }
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      redirect_to @gallery, notice: 'Gallery was successfully created.'
    else
      render :new
    end
  end

  # PUT /galleries/1
  def update
    if @gallery.update_attributes(params[:gallery])
      redirect_to @gallery, notice: 'Gallery was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /galleries/1
  def destroy
    @gallery.destroy
    redirect_to galleries_url
  end

private

  def fetch_gallery
    @gallery = Gallery.find params[:id]
  end

end
