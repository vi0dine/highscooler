module Types
  class QueryType < Types::BaseObject
    # USERS
    field :users, resolver: Queries::User::Users
    field :user, resolver: Queries::User::User
    # FIELDS OF STUDIES
    field :fields, resolver: Queries::FieldOfStudy::Fields
    field :field, resolver: Queries::FieldOfStudy::Field
  end
end
