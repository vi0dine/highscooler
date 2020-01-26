module Queries
  module Academy
    class Academies < Queries::BaseQuery
      description 'List all academies'

      type [Types::AcademyType], null: false

      def resolve
        user = context[:current_user]

        if !user
          GraphQL::ExecutionError.new("Nie masz uprawnień do wyświetlenia tych danych.")
        else
          ::Academy.all
        end
      end
    end
  end
end