module Mutations
    class AddLike < BaseMutation
        argument :tweet_id, ID, required: true 

        type Types::TweetType

        def resolve(tweet_id:)
            self.me?
            t = Tweet.find(tweet_id)
            Like.create!(user_id: me.id, tweet_id: t.id)
            t
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Either tweet doesn't exist or you already liked it")
        end
    end
end