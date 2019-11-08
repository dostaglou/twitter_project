module Resolvers
    class CurrentUser < Resolvers::Base
        type Types::UserType, null: false
        def resolve
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            context[:current_user]
        end
    end
end