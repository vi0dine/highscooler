# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :read, Academy
      if user.account_type == 'admin'
        can :create, :all
      end
    end
  end
end
