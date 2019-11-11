module Resolvers
    class UserTweetsSearch < Resolvers::Base
        argument :keyword, String, required: true
        argument :pagination, Types::Pagination, required: false
        argument :user_id, ID, required: true

        type [Types::TweetType], null: false
        
        def resolve(user_id:, pagination: [0,10], keyword:)
            Tweet.where(user_id: user_id).where("content like ?", "%#{keyword}%").order(id: "desc").offset(pagination[0]).limit(pagination[1])
        end
    end
end