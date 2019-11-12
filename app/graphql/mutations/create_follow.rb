module Mutations
    class CreateFollow < BaseMutation
        argument :target_id, ID, required: true 
        type Types::UserType
        def resolve(target_id:)
            self.me?
            u = User.find(target_id)
            unless me.id == target_id.to_i
                me.follow(target_id) 
                u.popularity += 1
                u.save
            end
            u
        rescue ActiveRecord::RecordNotFound => e
            GraphQL::ExecutionError.new("target user does not exist")
        end
    end
end
