module Resolvers
    class CurrentFeed < Resolvers::Base
        argument :pagination, Types::Pagination, required: false
        type [Types::TweetType], null: false
        def resolve(pagination:)
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            cu = context[:current_user]
            Tweet.where(user_id: [cu.following.select(:id)])&.offset(pagination[0])&.limit(pagination[1])
        end
    end
end