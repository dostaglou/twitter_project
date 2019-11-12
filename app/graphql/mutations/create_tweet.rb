module Mutations
    class CreateTweet < BaseMutation
        argument :content, String, required: true
        argument :parent_id, ID, required: false
        type Types::TweetType
        def resolve(content:, parent_id: nil)
            self.me?
            Tweet.create!(
                content: content,
                user_id: me.id,
                parent_id: parent_id
            )
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("target parent tweet doesn't exist")
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end