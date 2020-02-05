# frozen_string_literal: true

module Types
  class FieldOfStudyType < Base::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :academies, [Types::AcademyType], null: true
    field :reviews, [Types::ReviewType], null: true
    field :most_frequent_subjects, GraphQL::Types::JSON, null: true
  end
end