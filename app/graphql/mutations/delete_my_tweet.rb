module Mutations
    class DeleteMyTweet < BaseMutation
        argument :tweet_id, ID, required: true
        type String
        def resolve(tweet_id:)
            self.me?
            tweet = Tweet.find(tweet_id)
            if tweet.user == me
                tweet.delete 
            else
                 GraphQL::ExecutionError.new("This tweet belongs to someone else")
            end
            "This tweet has been deleted"
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("target tweet does not exist")
        end
    end
end