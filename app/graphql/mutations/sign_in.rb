module Mutations
    class SignIn < BaseMutation
        null true
        argument :args, Types::UserArgs, required: true
        field :token, String, null: true
        field :user, Types::UserType, null: true

        def resolve(args:)
            return unless args[:email]
            user = User.find_by email: args[:email]
            return unless user
            return unless user.authenticate(args[:password])
            crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
            token = crypt.encrypt_and_sign("user-id:#{ user.id }")
            { user: user, token: token }
        end
    end
end