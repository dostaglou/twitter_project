module Mutations
    class Unlike < BaseMutation
        argument :tweet_id, ID, required: true 

        field :original_tweet, Types::TweetType, null: true
        field :message, String, null: true

        def resolve(tweet_id:)
            self.me?
            t = Tweet.find(tweet_id)
            Like.find_by(user_id: me.id, tweet_id: t.id)&.destroy
            {original_tweet: t, message: "You unliked the tweet" }

        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Either tweet doesn't exist or you don't like it")
        end
    end
end