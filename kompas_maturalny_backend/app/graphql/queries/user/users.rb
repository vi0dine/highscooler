module Queries
  module User
    class Users < Queries::BaseQuery
      description 'List all users'

      type [Types::UserType], null: false

      def resolve
        user = context[:current_user]

        if user&.role != 'admin'
          GraphQL::ExecutionError.new("Nie masz uprawnień do wyświetlenia tych danych.")
        else
          ::User.all
        end
      end
    end
  end
end