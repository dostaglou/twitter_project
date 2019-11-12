module Types
  class QueryType < Types::BaseObject
    # Logged in Only Features
    
    field :my_tweets, resolver: Resolvers::MyTweets
    field :current_user, resolver: Resolvers::CurrentUser
    field :current_feed, resolver: Resolvers::CurrentFeed
    field :search_following_for, resolver: Resolvers::SearchFollowingFor

    # Anyone Features
    field :tweet_stats, resolver: Resolvers::TweetStats
    field :user_tweets_search, resolver: Resolvers::UserTweetsSearch
    field :find_user, resolver: Resolvers::FindUser
    field :topic_search, resolver: Resolvers::TopicSearch

  end
end
