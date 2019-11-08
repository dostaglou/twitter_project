class TwitterSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  max_complexity 10
end
