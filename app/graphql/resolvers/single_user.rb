module Resolvers
    class SingleUser < Resolvers::Base
        argument :user_id, ID, required: true
        type Types::UserType, null: false
        def resolve(user_id:)
            User.find(id)
        end
    end
end