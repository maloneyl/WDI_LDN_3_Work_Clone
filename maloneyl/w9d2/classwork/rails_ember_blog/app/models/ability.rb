class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can :manage, Post do |post|
        post.user == user
      end
      can :create, Post do
        user.persisted?
      end
    end
  end
end
