module Types
  class MutationType < Types::BaseObject
    field :sign_up_user, mutation: Mutations::Users::SignUpUser
    field :sign_in_user, mutation: Mutations::Users::SignInUser
    field :sign_out_user, mutation: Mutations::Users::SignOutUser
  end
end
