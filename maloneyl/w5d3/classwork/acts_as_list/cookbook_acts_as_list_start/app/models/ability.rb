class Ability
  include CanCan::Ability

  def initialize(user)

    #create a default new user if none passed
    user ||= User.new

    if user.role? :admin
      can :manage, :all

    else

      #all non-admins
      can :read, :all

      #author
      if user.role?(:author)
        can :create, Recipe
        can :update, Recipe do |recipe|
          recipe.user == user
        end
        can :destroy, Recipe do |recipe|
          recipe.user == user
        end
        can :manage, Quantity, :recipe => { :user_id => user.id }

      #moderator
      elsif user.role?(:moderator)
        can :flag, Recipe
        can :flagged, Recipe

      #chef
      elsif user.role?(:chef)
        can :manage, Ingredient
      end

    end
  end
end
