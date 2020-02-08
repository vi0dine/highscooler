module Queries
  module Academy
    class Academies < Queries::BaseQuery
      description 'List all academies'

      argument :query, String, required: false

      type Types::AcademyType.connection_type, null: false

      def resolve(query: nil)
        user = context[:current_user]

        if !user
          GraphQL::ExecutionError.new("Nie masz uprawnień do wyświetlenia tych danych.")
        elsif query
          ::Academy.search(query).records.to_a
        else
          ::Academy.all
        end
      end
    end
  end
end