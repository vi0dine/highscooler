module Types
  class QueryType < Types::BaseObject
    field :users, resolver: Queries::User::Users
    field :user, resolver: Queries::User::User
  end
end
