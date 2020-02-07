module Types
  module Base
  class QueryType < Types::Base::BaseObject
    # USERS
    field :users, resolver: Queries::User::Users
    field :user, resolver: Queries::User::User
    # FIELDS OF STUDIES
    field :fields, resolver: Queries::FieldOfStudy::Fields
    field :field, resolver: Queries::FieldOfStudy::Field
    # ACADEMIES
    field :academies, resolver: Queries::Academy::Academies
    field :academy, resolver: Queries::Academy::Academy
    # ACADEMY FIELD
    field :recruitment_points, resolver: Queries::AcademyField::UserRecruitmentResult
  end
  end
end
