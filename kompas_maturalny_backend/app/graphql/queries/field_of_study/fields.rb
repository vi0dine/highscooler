module Queries
  module FieldOfStudy
    class Fields < Queries::BaseQuery
      description 'List all fields of studies'

      argument :query, String, required: false

      type Types::FieldOfStudyType.connection_type, null: false

      def resolve(query: nil)
        user = context[:current_user]

        if !user
          GraphQL::ExecutionError.new("Nie masz uprawnień do wyświetlenia tych danych.")
        elsif query && query != ""
          ::FieldOfStudy.search(query).records.to_a
        else
          ::FieldOfStudy.all
        end
      end
    end
  end
end