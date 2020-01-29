module Queries
  module FieldOfStudy
    class Fields < Queries::BaseQuery
      description 'List all fields of studies'

      type Types::FieldOfStudyType.connection_type, null: false

      def resolve
        user = context[:current_user]

        if !user
          GraphQL::ExecutionError.new("Nie masz uprawnień do wyświetlenia tych danych.")
        else
          ::FieldOfStudy.all
        end
      end
    end
  end
end