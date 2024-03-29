class PaintingsController < ApplicationController
  # GET /paintings
  # GET /paintings.json
  def index
    @gallery = Gallery.find(params)[:gallery_id])
    @paintings = @gallery.paintings

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @paintings }
    end
  end

  # GET /paintings/1
  # GET /paintings/1.json
  def show
    @painting = Painting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @painting }
    end
  end

  # GET /paintings/new
  # GET /paintings/new.json
  def new
    @painting = Painting.new(:gallery_id => params[:gallery_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @painting }
    end
  end

  # GET /paintings/1/edit
  def edit
    @painting = Painting.find(params[:id])
  end

  # POST /paintings
  # POST /paintings.json
  def create
    @painting = Painting.new(params[:painting])

    respond_to do |format|
      if @painting.save
        format.html { redirect_to @painting, notice: 'Painting was successfully created.' }
        format.json { render json: @painting, status: :created, location: @painting }
      else
        format.html { render action: "new" }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /paintings/1
  # PUT /paintings/1.json
  def update
    @painting = Painting.find(params[:id])

    respond_to do |format|
      if @painting.update_attributes(params[:painting])
        format.html { redirect_to @painting, notice: 'Painting was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @painting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paintings/1
  # DELETE /paintings/1.json
  def destroy
    @painting = Painting.find(params[:id])
    @painting.destroy

    respond_to do |format|
      format.html { redirect_to gallery_url(@painting.gallery) }
      format.json { head :no_content }
    end
  end
end
