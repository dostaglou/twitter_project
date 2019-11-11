module Mutations
    class UpdateUser < BaseMutation
        argument :args, Types::UserArgs, required: true
        type Types::UserType
        def resolve(args:)
            self.me?
            me.update!(args.to_h)
            me
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end