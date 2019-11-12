module Mutations
    class AddLike < BaseMutation
        argument :tweet_id, ID, required: true 

        # type Types::TweetType
        field :original_tweet, Types::TweetType, null: true
        field :message, String, null: true

        def resolve(tweet_id:)
            self.me?
            t = Tweet.find(tweet_id)
            if Like.create!(user_id: me.id, tweet_id: t.id)
                t.popularity += 1 
                t.save
            end
            {original_tweet: t, message: "You liked the tweet" }
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("Tweet with that id not found")
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Either tweet doesn't exist or you already liked it")
        end
    end
end