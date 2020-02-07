module Queries
  module AcademyField
    class UserRecruitmentResult < Queries::BaseQuery
      description 'Get user results for given academy field'

      argument :id, ID, required: true

      type Integer, null: false

      def resolve(id:)
        user = context[:current_user]

        ::AcademyField.find(id).calculate_recruitment_points_for(user)
      end
    end
  end
end