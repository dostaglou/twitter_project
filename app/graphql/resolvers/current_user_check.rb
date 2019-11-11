module Resolvers
    class CurrentUserCheck < Resolvers::Base
    
      def resolve
        return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
        current = context[:current_user]
      end
    end
end