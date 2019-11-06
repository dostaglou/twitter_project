module Types
  class QueryType < Types::BaseObject
    field :user, resolver: Resolvers::SingleUser
    field :users, resolver: Resolvers::AllUsers
    field :tweet, resolver: Resolvers::SingleTweet
    field :tweets, resolver: Resolvers::AllTweets
    field :user_tweets, resolver: Resolvers::UserTweets 

  end
end
