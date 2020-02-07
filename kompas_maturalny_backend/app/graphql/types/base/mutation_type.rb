module Types
  module Base
    class MutationType < Types::Base::BaseObject
      field :sign_up_user, mutation: Mutations::Users::SignUpUser
      field :sign_in_user, mutation: Mutations::Users::SignInUser
      field :sign_out_user, mutation: Mutations::Users::SignOutUser
      field :add_user_field, mutation: Mutations::Fields::AddUserField
      field :remove_user_field, mutation: Mutations::Fields::RemoveUserField
    end
  end
end
