module Types
  module Base
  class BaseObject < GraphQL::Schema::Object
    field_class Types::Base::BaseField
    connection_type_class Types::CustomConnection
  end
  end
end
