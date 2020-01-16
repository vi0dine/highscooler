# frozen_string_literal: true

module Types
  class UserType < BaseObject
    field :gender, Types::Enums::Gender, null: true
    field :role, Types::Enums::Role, null: false

    field :id, ID, null: false

    field :username, String, null: true
    field :email, String, null: false
    field :city, String, null: true
    field :date_of_birth, GraphQL::Types::ISO8601DateTime, null: true
    field :date_of_matura, GraphQL::Types::ISO8601DateTime, null: true
  end
end