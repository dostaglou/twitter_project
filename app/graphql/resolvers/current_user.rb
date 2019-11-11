module Resolvers
    class CurrentUser < Resolvers::CurrentUserCheck
        type Types::UserType, null: false
        def resolve
            self.cuc
            me
        end
    end
end