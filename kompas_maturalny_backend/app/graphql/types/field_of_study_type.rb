# frozen_string_literal: true

module Types
  class FieldOfStudyType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :academies, [Types::AcademyType], null: true
  end
end