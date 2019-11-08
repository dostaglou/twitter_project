module Mutations
    class DeleteMyTweet < BaseMutation
        argument :tweet_id, ID, required: true
        type Types::UserType
        def resolve(tweet_id:)
            tweet = Tweet.find(tweet_id)
            if tweet.user == context[:current_user] 
                tweet.delete 
            else
                 GraphQL::ExecutionError.new("This tweet belongs to someone else")
            end
            context[:current_user]
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("target tweet does not exist")
        end
    end
end