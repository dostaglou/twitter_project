module Resolvers
    class CurrentFeed < Resolvers::Base
        type [Types::TweetType], null: false
        def resolve
            user = context[:current_user]
            tweets = Tweet.where("user_id is #{user.id} or user_id is 1")
            tweets
        end
    end
end