module Mutations
    class ExterminateUser < BaseMutation
        type String
        def resolve
            self.me?
            me&.destroy
            "YOU NO LONGER EXIST IN OUR DATABASE! I HOPE YOU ARE PROUD OF YOURSELF!"
        end
    end
end