module Mutations
    class Unfollow < BaseMutation
        argument :user_id, ID, required: true
        type Types::UserType

        def resolve (user_id:)
            return unless context[:current_user] != user_id
            context[:current_user].unfollow(id)
            context[:current_user]
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end