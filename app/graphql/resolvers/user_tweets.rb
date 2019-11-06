module Resolvers
    class UserTweets < Resolvers::Base
        argument :user_id, ID, required: true
        type [Types::TweetType], null: false
        def resolve(user_id:)
            User.find(user_id)&.tweets
        end
    end
end