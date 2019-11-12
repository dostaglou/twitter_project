module Mutations
    class Unlike < BaseMutation
        argument :tweet_id, ID, required: true 

        type Types::TweetType

        def resolve(tweet_id:)
            self.me?
            t = Tweet.find(tweet_id)
            Like.find_by(user_id: me.id, tweet_id: t.id)&.destroy
            t
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Either tweet doesn't exist or you don't like it")
        end
    end
end