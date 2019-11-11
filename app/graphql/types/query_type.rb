module Types
  class QueryType < Types::BaseObject
    field :find_user, resolver: Resolvers::FindUser
    # field :users, resolver: Resolvers::AllUsers
    # field :tweet, resolver: Resolvers::SingleTweet
    field :user_tweets_search, resolver: Resolvers::UserTweetsSearch
    # field :user_tweets, resolver: Resolvers::UserTweets 
    field :my_tweets, resolver: Resolvers::MyTweets
    field :current_user, resolver: Resolvers::CurrentUser
    field :current_feed, resolver: Resolvers::CurrentFeed
    field :search_following_for, resolver: Resolvers::SearchFollowingFor
    field :tweet_stats, resolver: Resolvers::TweetStats
    field :topic_search, resolver: Resolvers::TopicSearch

  end
end
