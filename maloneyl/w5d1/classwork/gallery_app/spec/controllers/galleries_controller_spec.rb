require 'spec_helper'

describe GalleriesController do 

  describe 'GET index' do 
    before do # create dummy data
      @galleries_fake_data = 10.times.map{ Gallery.create(name: 'WDI') }
    end

    it 'should assign @galleries' do 
      get :index # based on the describe name 'GalleriesController', rspec will know which index to go to
      expect(assigns[:galleries]).to eq(@galleries_fake_data) # assigns[:galleries] refers to @galleries in galleries_controller
    end

    it 'should respond with instances of gallery' do 
      get :index
      expect(assigns[:galleries].first.class).to eq(Gallery) # see if the first instance of assigns[:galleries] has Gallery as a class!
    end

    it 'should respond with a 200 status' do # 200 is OK
      get :index
      expect(response.status).to eq(200) # response is built-in and has a status method
    end

    it 'should render the index template' do 
      get :index
      expect(response).to render_template('index') # render_template is a helper
    end
  end

  describe 'GET show' do 
    before do
      @gallery_fake_data = Gallery.create(name: 'Test Gallery') # just one gallery here because 'show' shows one gallery only
    end

    it 'should assign @gallery' do
      get :show, {id: @gallery_fake_data.id} # the id hash represents params that we'd have in the real thing
      expect(assigns[:gallery]).to eq(@gallery_fake_data)
    end

    it 'should render the show template' do 
      get :show, {id: @gallery_fake_data.id}
      expect(response).to render_template('show') # render_template is a helper
    end
  end

  describe 'POST create' do 
    let(:params) { {gallery:{name: 'Some Gallery'}} } # create a variable named params with the values passed in the block

    it 'should create the gallery with given information' do
      post :create, params # post to our create method with the values of params
      expect(assigns[:gallery].name).to eq(params[:gallery][:name])
    end

    it 'should redirect to galleries/show page' do
      post :create, params
      expect(response).to redirect_to gallery_path(assigns[:gallery])
    end
    
  end

end
