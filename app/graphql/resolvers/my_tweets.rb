module Resolvers
    class MyTweets < Resolvers::Base
        type [Types::TweetType], null: false
        def resolve
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            context[:current_user]&.tweets
        end
    end
end