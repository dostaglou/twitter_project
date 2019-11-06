module Types
    class TweetType < BaseObject
        field :id, ID, null: true
        field :user, Types::UserType, null: true
        field :content, String, null: true
    end
end