module Mutations
    class UpdateUser < BaseMutation
        argument :args, Types::UserArgs, required: true
        type Types::UserType
        def resolve(args:)
            data = {username: args[:username], email: args[:email], password: args[:password], bio: args[:bio]}
            data.reject!{ |_key, value| value == nil }
            context[:current_user].update(data)
            context[:current_user]
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end