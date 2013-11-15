require 'spec_helper' # which will 'require' the gem capybara for us

describe Ingredient do # when we use a proper class name, rspec defines the subject ("it" below) as related to the Ingredient model
  describe "validations" do
    it{ should validate_presence_of :name } # one-line syntax
    it{ should validate_uniqueness_of :name }
    it{ should validate_presence_of :image }
  end

  describe "mass assignment" do
    it{ should allow_mass_assignment_of :name }
    it{ should allow_mass_assignment_of :image }
    # it{ should_not allow_mass_assignment_of :some_attribute } # if we need the opposite
  end

end
