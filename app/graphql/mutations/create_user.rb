module Mutations
    class CreateUser < BaseMutation    
        argument :args, Types::UserArgs, required: true
        type Types::UserType
        def resolve(args: )
            User.create( 
                username: args[:username],
                email: args[:email],
                password: args[:password],
                bio: args[:bio],
            )
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end