module Queries
  module Academy
    class Academy < Queries::BaseQuery
      description 'Find academy by ID'

      argument :id, ID, required: true

      type Types::AcademyType, null: false

      def resolve(id:)
        ::Academy.find(id)
      end
    end
  end
end