module Queries
  module FieldOfStudy
    class Field < Queries::BaseQuery
      description 'Find field of study by ID'

      argument :id, ID, required: true

      type Types::FieldOfStudyType, null: false

      def resolve(id:)
        ::FieldOfStudy.find(id)
      end
    end
  end
end