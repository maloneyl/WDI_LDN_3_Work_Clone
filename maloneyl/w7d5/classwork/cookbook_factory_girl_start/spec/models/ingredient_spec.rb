require "spec_helper"

describe Ingredient do

  describe "#validations" do
    it{ should validate_presence_of :name}
    it{ should validate_uniqueness_of :name}
    it{ should validate_presence_of :image}
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :image }
  end
end 