require 'spec_helper'
require 'cancan/matchers' # gem needed to test cancan, gives us nice helpers like be_able_to that takes args like what we have in our ability.rb

describe "User" do # not User as a class name, but User the string, because we're really testing the class Ability instead
  describe "abilities" do
    subject(:ability) { Ability.new(user) } # subject needs to be specified here instead of just "it" because up until now we haven't defined a class name

    context "when is an admin" do
      let!(:user) { User.new(role: "admin") } # which then gets passed to the subject
      it { should be_able_to(:manage, :all) } # here we can use 'it' because the subject has been defined
    end

    context "when is an author" do
      let!(:user) { User.new(role: "author") }
      it { should_not be_able_to(:manage, :all) }
      it { should be_able_to(:read, :all) }
      it { should be_able_to(:create, Recipe) }
      it { should_not be_able_to(:manage, User) }
      it { should be_able_to(:manage, Recipe do |recipe|
        recipe.user == user
      end)
      }
    end

    context "when is a moderator" do
      let!(:user) { User.new(role: "moderator") }
      it { should_not be_able_to(:manage, :all) }
      it { should be_able_to(:read, :all) }
    end

    context "when is a chef" do
      let!(:user) { User.new(role: "chef") }
      it { should_not be_able_to(:manage, :all) }
      it { should be_able_to(:read, :all) }
    end

  end
end
