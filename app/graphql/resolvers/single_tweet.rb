module Resolvers
    class SingleTweet < Resolvers::Base
        argument :id, ID, required: true
        type Types::TweetType, null: false
        def resolve(id:)
            Tweet.find(id)
        end
    end
end