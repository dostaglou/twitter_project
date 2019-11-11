module Types
    class UserType < BaseObject
        field :id, ID, null: false
        field :email, String, null: false
        field :bio, String, null: true
        field :username, String, null: true
        field :tweets, [Types::TweetType], null: true
        field :following, [Types::UserType], null: true
        field :followers, [Types::UserType], null: true
        field :following_count, Integer, null: true
        field :followers_count, Integer, null: true
        field :tweet_count, Integer, null: true


        def following_count
            object.following.count
        end

        def followers_count
            object.followers.count
        end

        def tweet_count
            object.tweets.count
        end
    end
end