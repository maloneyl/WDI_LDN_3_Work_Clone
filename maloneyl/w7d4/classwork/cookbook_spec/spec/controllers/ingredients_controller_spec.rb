require 'spec_helper'

describe IngredientsController do
  describe "GET index" do # this is for our info
    let!(:ingredients) { 3.times.map{ |i| Ingredient.create(name: "Ingredient #{i}", image: "Image") } } # define the var for the scope of the test
    # it WON'T WORK with 'let' instead of 'let!' (the latter runs the code as soon as ruby sees it)
    # we need to specify image in our dummy data beacuse our Ingredients model validates presence of image too

    it "should instantiate @ingredients with all ingredients in the database" do # it refers to the test
      get :index # http verbs: get, post, put, delete; mapping index func of IngredientsController
      expect(assigns[:ingredients]).to eq(ingredients) # assigns: gets an array of the instance var @ingredients, while the eq(ingredients) refers to the ingredients defined in let!
    end

    it "should render index template" do
      get :index
      expect(response).to render_template("index")
    end

  end
end
