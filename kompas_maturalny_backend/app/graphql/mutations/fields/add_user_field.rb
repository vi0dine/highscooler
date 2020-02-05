module Mutations
  module Fields
    class AddUserField < BaseMutation
      argument :fieldId, ID, required: true

      field :user_field, Types::UserFieldType, null: false

      def resolve(field_id: nil)
        user = context[:current_user]

        if user.present?
          user_field = UserField.create!(field_of_study: FieldOfStudy.find(field_id), user: user)
          {
              user_field: user_field
          }
        else
          GraphQL::ExecutionError.new("Nie można dodać kierunku do użytkownika")
        end
      end
    end
  end
end