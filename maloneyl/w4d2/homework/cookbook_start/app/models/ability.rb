class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all
      cannot :flag, :all
      cannot :flagged, :all
    elsif user.role? :moderator
      can :read, :all
      can :flag, :all
      can :flagged, :all
      can :manage, User
    elsif user.role? :chef
      can :manage, Ingredient
      can :read, :all
    else
      can :read, :all
      if user.role? :author
        can :create, Recipe
        can :update, Recipe do |recipe| # i.e. can only update the user's own recipe only
          recipe.user == user
        end
        can :destroy, Recipe do |recipe| # i.e. can only delete the user's own recipe only
          recipe.user == user
        end
        can :manage, Quantity, :recipe => { :user_id => user.id } # i.e. can only update the user's own recipe only; our recipes table has a user_id, and that should fit user.id
      end
    end
  end
end