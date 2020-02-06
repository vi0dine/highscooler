# frozen_string_literal: true

module Types
  class UserType < Base::BaseObject
    field :gender, Types::Enums::Gender, null: true
    field :role, Types::Enums::Role, null: false

    field :id, ID, null: false

    field :username, String, null: true
    field :email, String, null: false
    field :city, String, null: true
    field :date_of_birth, GraphQL::Types::ISO8601DateTime, null: true
    field :date_of_matura, GraphQL::Types::ISO8601DateTime, null: true
    field :authentication_token, String, null: true

    field :user_fields, [Types::UserFieldType], null: true

    def authentication_token
      if object.gql_id != context[:current_user]&.gql_id
        raise GraphQL::UnauthorizedFieldError,
              "Unable to access authentication_token"
      end

      object.authentication_token
    end
  end
end