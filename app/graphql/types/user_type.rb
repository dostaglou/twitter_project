module Types
    class UserType < BaseObject
        field :id, ID, null: false
        field :email, String, null: false
        field :bio, String, null: true
        field :username, String, null: true
        field :tweets, [Types::TweetType], null: true
        field :following, [Types::UserType], null: true
        field :followers, [Types::UserType], null: true
    end
end