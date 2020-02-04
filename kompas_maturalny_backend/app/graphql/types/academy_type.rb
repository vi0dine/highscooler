# frozen_string_literal: true

module Types
  class AcademyType < Base::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :city, String, null: false
    field :field_of_studies, [Types::FieldOfStudyType], null: true
    field :reviews, [Types::ReviewType], null: true
  end
end