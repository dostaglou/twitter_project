module Mutations
    class AddLike < BaseMutation
        argument :tweet_id, ID, required: true 

        # type Types::TweetType
        field :original_tweet, Types::TweetType, null: true
        field :message, String, null: true

        def resolve(tweet_id:)
            self.me?
            t = Tweet.find(tweet_id)
            Like.create!(user_id: me.id, tweet_id: t.id)
            {original_tweet: t, message: "You liked the tweet" }
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Either tweet doesn't exist or you already liked it")
        end
    end
end