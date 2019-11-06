module Mutations
    class DeleteMyTweet < BaseMutation
        argument :tweet_id, ID, required: true
        type Types::UserType
        def resolve(tweet_id:)
            tweet = Tweet.find(tweet_id)
            tweet.delete if tweet.user == context[:current_user]
            context[:current_user]
        end
    end
end