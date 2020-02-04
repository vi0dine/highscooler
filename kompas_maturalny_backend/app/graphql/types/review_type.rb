# frozen_string_literal: true

module Types
  class ReviewType < Base::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :body, String, null: false
    field :rate, Int, null: false
    field :user, Types::UserType, null: false
    field :reviewable, Types::AcademyFieldType, null: false
  end
end