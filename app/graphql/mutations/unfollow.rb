module Mutations
    class Unfollow < BaseMutation
        argument :user_id, ID, required: true
        
        field :msg, String, null: true
        field :user, Types::UserType, null: true
        def resolve (user_id:)
            u = User.find(user_id)
            unless u.nil?
                if me.unfollow(user_id)
                    u.popularity -= 1
                end
            end
            {msg: "You do not follow that user", user: u}
            
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("User with user_id of #{user_id} not found")
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end