# frozen_string_literal: true

module Types
  class AcademyType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :description, String, null: false
    field :city, String, null: false
  end
end