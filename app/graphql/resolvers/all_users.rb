module Resolvers
    class AllUsers < Resolvers::Base
        type [Types::UserType], null: false
        def resolve
            User.all
        end
    end
end