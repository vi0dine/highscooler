module Mutations
  module Users
    class SignUpUser < BaseMutation
      argument :username, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :role, Types::Enums::Role, required: false

      field :user, Types::UserType, null: true
      field :errors, [String], null: false

      def resolve(username:nil, email: nil, password: nil, role: "schoolboy")
        user = User.create!(
            username: username,
            email: email,
            password: password,
            role: role
        )

        context[:current_user] = user

          {
              user: user,
              errors: []
          }

      rescue ActiveRecord::RecordInvalid => invalid
        GraphQL::ExecutionError.new(
            "Invalid Attributes for #{invalid.record.class.name}: " \
        "#{invalid.record.errors.full_messages.join(', ')}"
        )
      end
    end
  end
end