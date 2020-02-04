# frozen_string_literal: true

module Types
  class AcademyFieldType < Base::BaseObject
    field :id, ID, null: false
    field :academy, Types::AcademyType, null: false
    field :field_of_study, Types::FieldOfStudyType, null: false
    field :recruitment_formula, String, null: false
  end
end