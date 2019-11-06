module Types
    class UserType < BaseObject
        field :id, ID, null: false
        field :email, String, null: false
        field :bio, String, null: true
        field :username, String, null: true
        field :tweets, [Types::TweetType], null: true
    end
end