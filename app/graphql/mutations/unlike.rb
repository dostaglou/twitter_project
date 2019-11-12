module Mutations
    class Unlike < BaseMutation
        argument :tweet_id, ID, required: true 

        field :original_tweet, Types::TweetType, null: true
        field :message, String, null: true

        def resolve(tweet_id:)
            self.me?
            t = Tweet.find(tweet_id) 
            if Like.find_by(user_id: me.id, tweet_id: t.id)&.destroy
                t.popularity -= 1
                t.save
            end
            {original_tweet: t, message: "You unliked the tweet" }
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("A tweet with that id not found")
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Either tweet doesn't exist or you don't like it")
        end
    end
end