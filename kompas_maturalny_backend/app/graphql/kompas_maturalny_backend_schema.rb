class KompasMaturalnyBackendSchema < GraphQL::Schema
  mutation(Types::Base::MutationType)
  query(Types::Base::QueryType)
end
