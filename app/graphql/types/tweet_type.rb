module Types
    class TweetType < BaseObject
        field :id, ID, null: true
        field :user, Types::UserType, null: true
        field :content, String, null: true
        field :likes, Integer, null: true
        field :popularity, Integer, null: false
        field :children, [Types::TweetType], null: true
        field :parent, Types::TweetType, null: true
    end
end