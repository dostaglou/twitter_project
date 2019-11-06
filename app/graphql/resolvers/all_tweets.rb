module Resolvers
    class AllTweets < Resolvers::Base
        type [Types::TweetType], null: false
        def resolve
            Tweet.all
        end
    end
end