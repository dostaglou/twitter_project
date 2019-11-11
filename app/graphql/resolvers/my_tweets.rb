module Resolvers
    class MyTweets < Resolvers::CurrentUserCheck

        argument :pagination, Types::Pagination, required: false

        type [Types::TweetType], null: false
        
        def resolve(pagination: [0, 10])
            self.cuc
            me&.tweets&.offset(pagination[0])&.limit(pagination[1])
        end
    end
end