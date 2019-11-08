module Mutations
    class CreateFollow < BaseMutation
        argument :target_id, ID, required: true 
        type Types::UserType
        def resolve(target_id:)
            context[:current_user].follow(target_id)
            context[:current_user]
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("target user does not exist")
        end
    end
end
