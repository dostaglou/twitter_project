module Resolvers
    class SingleUser < Resolvers::Base
        argument :id, ID, required: true

        type Types::UserType, null: false

        def resolve(id:)
            User.find(id)
        end
    end
end