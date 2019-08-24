# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :read, User, id: user.id
      can :read, FieldOfStudy
      can :read, Academy
      if user.account_type == 'admin'
        can :manage, :all
      end
    end
  end
end
