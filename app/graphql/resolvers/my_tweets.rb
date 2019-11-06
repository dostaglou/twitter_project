module Resolvers
    class MyTweets < Resolvers::Base
        type [Types::TweetType], null: false
        def resolve
            context[:current_user].tweets
        end
    end
end