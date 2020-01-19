module Queries
  module User
    class User < Queries::BaseQuery
      description 'Find an user by ID'

      argument :id, ID, required: true

      type Types::UserType, null: false

      def resolve(id:)
        ::User.find(id)
      end
    end
  end
end