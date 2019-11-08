module Mutations
    class SignIn < BaseMutation
        null true
        argument :args, Types::UserArgs, required: true
        field :token, String, null: true
        field :user, Types::UserType, null: true

        def resolve(args:)
            return unless args[:email]
            user = User.find_by email: args[:email]
            return GraphQL::ExecutionError.new("User with that email not found") unless user
            return GraphQL::ExecutionError.new("Password was incorrect") unless user.authenticate(args[:password])
            crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
            token = crypt.encrypt_and_sign("user-id:#{ user.id }")
            { user: user, token: token }
        rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end