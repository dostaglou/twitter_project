module Resolvers
    class MyTweets < Resolvers::Base

        argument :pagination, Types::Pagination, required: false

        type [Types::TweetType], null: false
        
        def resolve(pagination:)
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            context[:current_user]&.tweets&.offset(pagination[0])&.limit(pagination[1])
        end
    end
end