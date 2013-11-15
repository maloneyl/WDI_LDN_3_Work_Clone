require 'spec_helper'

describe "ingredients/index.html.haml" do
  let(:ingredients) { 3.times.map{ |i| Ingredient.create(name: "Ingredient #{i}", image: "Image") } }
  # let sans ! here

  before(:each) do
    assign :ingredients, ingredients # again, :ingredients is the instance var created with the var ingredients defined above
  end

  describe "with 3 ingredients" do
    before(:each) do
      controller.stub(:current_user).and_return(User.new) # because our index.html.haml invokes the "if can? :blah blah" method, which needs a current_user to work
      render # this gives us access to the 'rendered' variable that contains the rendered html
    end

    it "should have 3 rows containing ingredients" do
      # puts rendered
      rendered.should have_selector "ol li div.ingredient", count: 3 # css path, so we're really looking for that nested div.ingredient 3 times, not saying ol, li, etc. should appear 3 times
    end

    it "should have a link to show the ingredient page" do
      rendered.should have_link(ingredients.first.name, href: ingredient_path(ingredients.first)) # 1st arg is text of our link, 2nd is link (our rails helper paths still valid here)
    end
  end

  describe "as an admin" do # context doesn't overwrite vars defined before
    before(:each) do
      controller.stub(:current_user).and_return(User.new(role: "admin")) # note role passed in
      render
    end

    it "should render a link to create a new ingredient" do
      puts rendered
      rendered.should have_link("New Ingredient") # 2nd arg for href optional here because we don't really need to test that link when it's not all that dynamic
    end
  end

end
