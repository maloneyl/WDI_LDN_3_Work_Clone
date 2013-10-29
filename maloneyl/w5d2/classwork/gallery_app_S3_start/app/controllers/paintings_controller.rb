class PaintingsController < ApplicationController

  before_filter :fetch_gallery
  before_filter :fetch_painting, only: [:show, :edit, :update, :destroy]

  # GET /gallery/99/paintings
  def index
    @paintings = @gallery.paintings
    redirect_to @gallery
  end

  # GET /gallery/99/paintings/1
  def show
  end

  # GET /gallery/99/paintings/new
  def new
    @painting = @gallery.paintings.build
  end

  # GET /gallery/99/paintings/1/edit
  def edit
  end

  # POST /gallery/99/paintings
  def create
    @painting = @gallery.paintings.build params[:painting]
    if @painting.save
      redirect_to gallery_painting_path(@gallery, @painting), notice: 'Painting was successfully created.'
    else
      render :new
    end
  end

  # PUT /gallery/99/paintings/1
  def update
    if @painting.update_attributes params[:painting]
      redirect_to gallery_painting_path(@gallery, @painting), notice: 'Painting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /gallery/99/paintings/1
  def destroy
    @painting.destroy
    redirect_to gallery_url(@gallery)
  end

private

  def fetch_gallery
    @gallery = Gallery.find params[:gallery_id]
  end

  def fetch_painting
    @painting = @gallery.paintings.find params[:id]
  end

end
