# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      can :read, User, id: user.id
      can :read, FieldOfStudy
      can :read, Academy
      can :create, Interested, user_id: user.id
      if user.account_type == 'student'
        can :create, FieldOpinion, field_of_study_id: user.field_of_study_id
        can :create, AcademyOpinion, academy_id: user.academy_id
      end
      if user.account_type == 'admin'
        can :manage, :all
      end
    end
  end
end
