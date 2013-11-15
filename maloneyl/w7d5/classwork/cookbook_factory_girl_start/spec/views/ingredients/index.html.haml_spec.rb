require "spec_helper"

describe "ingredients/index.html.haml", type: :feature do
  let(:ingredients) { 3.times.map{ |t| Ingredient.create name: "recipe#{t}", image: "recipe-image#{t}" } }

  before(:each) do
    controller.stub(:current_user).and_return( User.new)
    
    assign :ingredients, ingredients
    render
  end
  context "with 3 ingredients" do


    it "should have 3 rows containing recipes" do
      rendered.should have_selector "ol li div.ingredient", count: 3
    end

    it "should have a link to show ingredient " do
      rendered.should have_link(ingredients.first.name, href: ingredient_path(ingredients.first))
    end
  end
end