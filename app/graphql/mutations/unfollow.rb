module Mutations
    class Unfollow < BaseMutation
        argument :user_id, ID, required: true
        type Types::UserType
        def resolve (user_id:)
            return GraphQL::ExecutionError.new ("You MUST follow yourself for the User Feed to work properly") unless context[:current_user].id != user_id.to_i
            context[:current_user].unfollow(user_id)
            context[:current_user]
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end