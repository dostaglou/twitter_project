module Mutations
    class CreateFollow < BaseMutation
        argument :target_id, ID, required: true 
        type Types::UserType
        def resolve(target_id:)
            context[:current_user].follow(target_id)
            context[:current_user]
        end
    end
end
