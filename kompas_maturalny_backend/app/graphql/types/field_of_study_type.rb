# frozen_string_literal: true

module Types
  class FieldOfStudyType < BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :description, String, null: false
  end
end