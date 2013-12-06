class TelevisionsController < ApplicationController
  # GET /televisions
  # GET /televisions.json
  def index
    @televisions = Television.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @televisions }
    end
  end

  # GET /televisions/1
  # GET /televisions/1.json
  def show
    @television = Television.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @television }
    end
  end

  # GET /televisions/new
  # GET /televisions/new.json
  def new
    @television = Television.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @television }
    end
  end

  # GET /televisions/1/edit
  def edit
    @television = Television.find(params[:id])
  end

  # POST /televisions
  # POST /televisions.json
  def create
    @television = Television.new(params[:television])

    respond_to do |format|
      if @television.save
        format.html { redirect_to @television, notice: 'Television was successfully created.' }
        format.json { render json: @television, status: :created, location: @television }
      else
        format.html { render action: "new" }
        format.json { render json: @television.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /televisions/1
  # PUT /televisions/1.json
  def update
    @television = Television.find(params[:id])

    respond_to do |format|
      if @television.update_attributes(params[:television])
        format.html { redirect_to @television, notice: 'Television was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @television.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /televisions/1
  # DELETE /televisions/1.json
  def destroy
    @television = Television.find(params[:id])
    @television.destroy

    respond_to do |format|
      format.html { redirect_to televisions_url }
      format.json { head :no_content }
    end
  end
end
