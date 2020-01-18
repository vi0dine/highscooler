module Mutations
  module Users
    class SignOutUser < BaseMutation

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(email: nil, password: nil)
        user = context[:current_user]

        if user.present?
          user.reset_authentication_token!
            context[:current_user] = user
            {
                user: user,
                errors: []
            }
        else
          GraphQL::ExecutionError.new("User not signed in")
        end
      end
    end
  end
end