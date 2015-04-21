class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user && user.admin?
      can :access, :rails_admin
      can :dashboard
      can :manage, :all
    elsif user && user.student?
      can :manage, Article, user_id: user.id
      can :manage, Category
    elsif user && user.tutor?
      can :read, Article
    end
  end
end
