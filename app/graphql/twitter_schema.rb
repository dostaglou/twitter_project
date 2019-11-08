class TwitterSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
  max_complexity 200
end
