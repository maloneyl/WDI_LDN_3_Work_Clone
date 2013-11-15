require 'spec_helper'

describe User do

  context "when is an author with recipes" do
    let!(:user){ FactoryGirl.create :author_with_recipes, recipe_count: 5 }

    it "has the correct recipe count" do
      user.recipes.count.should == 5
    end
  end

end
