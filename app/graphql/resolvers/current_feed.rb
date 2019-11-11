module Resolvers
    class CurrentFeed < Resolvers::CurrentUserCheck
        argument :pagination, Types::Pagination, required: false
        type [Types::TweetType], null: false
        def resolve(pagination:[0,10])
            self.cuc
            Tweet.where(user_id: [me.id, me.following.select(:id)].flatten)&.order(id: "DESC")&.offset(pagination[0])&.limit(pagination[1])
        end
    end
end