module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::Base::BaseArgument
    field_class Types::Base::BaseField
    input_object_class Types::Base::BaseInputObject
    object_class Types::Base::BaseObject

    def authorize_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, "User not signed in"
    end
  end
end
