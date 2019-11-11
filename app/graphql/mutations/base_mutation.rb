module Mutations
    class BaseMutation < GraphQL::Schema::Mutation
        null false

        def me?
            raise GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
        end
        def me
            context[:current_user]
        end
    end
end