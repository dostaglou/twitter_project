module Mutations
    class Unfollow < BaseMutation
        argument :user_id, ID, required: true
        type String
        
        def resolve (user_id:)
            me.unfollow(user_id)
            "You no longer follow that user"
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end