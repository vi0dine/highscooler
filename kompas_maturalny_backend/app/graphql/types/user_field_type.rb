# frozen_string_literal: true

module Types
  class UserFieldType < Base::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :field_of_study, Types::FieldOfStudyType, null: false
  end
end