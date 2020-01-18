module Mutations
  module Users
    class SignInUser < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(email: nil, password: nil)
        user = User.find_for_database_authentication(email: email)

        if user.present?
          if user.valid_password?(password)
            context[:current_user] = user
            {
                user: user,
                errors: []
            }
          else
            GraphQL::ExecutionError.new("Incorrect Email/Password")
          end
        else
            GraphQL::ExecutionError.new("User not registered on this application")
        end
      end
    end
  end
end