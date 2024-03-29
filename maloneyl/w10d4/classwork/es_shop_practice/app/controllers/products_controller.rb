class ProductsController < ApplicationController

  before_filter :redirect_to_product_vertical, only: [:index]

  # GET /products
  # GET /products.json
  def index # because there's no /products/index.html, rails will then look into /application and render index.html there
    search    = product_class.s params, load: true
    @products = search.results
    @facets   = @products.facets
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  def product_class
    Product # product_class returns Product in ProductsController; but CamerasController product_class is made to return Camera, etc. small trick to reuse code
  end

  def redirect_to_product_vertical
    return unless self.class == ProductsController
    begin
      product_type = params["terms"]["product_type"].find do |value, checked|
        checked == "true"
      end.first
      params.delete("controller")
      redirect_to send("#{product_type.pluralize}_path", params) if product_type
    rescue
      nil
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  # GET /products/new.json
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end
end
