module Mutations
    class CreateTweet < BaseMutation
        argument :content, String, required: true
        type Types::TweetType
        def resolve(content:)
            self.me?
            Tweet.create!(
                content: content,
                user_id: me.id
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end