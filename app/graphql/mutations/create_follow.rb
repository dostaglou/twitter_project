module Mutations
    class CreateFollow < BaseMutation
        argument :target_id, ID, required: true 
        type Types::UserType
        def resolve(target_id:)
            context[:current_user].follow(target_id) unless context[:current_user].id == target_id.to_i
            User.find(target_id)
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("target user does not exist")
        end
    end
end
