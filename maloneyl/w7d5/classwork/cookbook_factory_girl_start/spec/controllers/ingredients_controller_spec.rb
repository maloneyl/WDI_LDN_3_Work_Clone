require "spec_helper"

describe IngredientsController do
  describe "GET Index" do
    # let!(:ingredients) { 3.times.map{ |index| Ingredient.create(name: "an ingredient #{index}", image: "boom")}}
    let!(:ingredients) { FactoryGirl.create_list :ingredient, 3 }

    it "should instantiate @ingredients" do
      get :index
      expect(assigns[:ingredients]).to eq(ingredients)
    end

    it "should render index" do
      get :index
      expect(response).to render_template("index")
    end
  end

end
