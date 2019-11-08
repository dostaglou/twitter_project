module Mutations
    class ExterminateUser < BaseMutation
        type Types::UserType
        def resolve
            context[:current_user]&.destroy
            context[:current_user]
        end
    end
end