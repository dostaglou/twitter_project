module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Resolvers::SingleUser
    field :users, resolver: Resolvers::AllUsers
    field :tweet, resolver: Resolvers::SingleTweet
    field :tweets, resolver: Resolvers::AllTweets
    field :user_tweets, resolver: Resolvers::UserTweets 
    field :my_tweets, resolver: Resolvers::MyTweets
    field :current_user, resolver: Resolvers::CurrentUser
    field :current_feed, resolver: Resolvers::CurrentFeed
    field :search_following, resolver: Resolvers::SearchFollowing
  
  end
end
