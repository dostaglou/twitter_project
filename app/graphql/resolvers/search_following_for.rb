module Resolvers
    class SearchFollowingFor < Resolvers::Base
        argument :keyword, String, required: true
        argument :pagination, Types::Pagination, required: false
        argument :ownership_filter, Types::OwnershipFilter, required: false

        type [Types::TweetType], null: false

        def resolve(pagination:, keyword:, ownership_filter:)
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            cu = context[:current_user]
            return GraphQL::ExecutionError.new("You must provide a keyword! No empty string searches") if keyword == ""
            
            case
            when ownership_filter ==  "self"
                # self only
                return Tweet.where(user_id: cu.id).where("content like ? ", "%#{keyword}%")&.order(id: "desc").offset(pagination[0] * 10).limit(pagination[1])
            when ownership_filter == "following"
                # theirs
                return Tweet.where(user_id: [cu.following.select(:id)]).where("content like ? ", "%#{keyword}%")&.order(id: "desc").offset(pagination[0] * 10).limit(pagination[1])
            else
                # all
                return Tweet.where(user_id: [ cu.id, cu.following.select(:id)].flatten).where("content like ?", "%#{keyword}%")&.order(id: "desc").offset(pagination[0] * 10).limit(pagination[1])
            end
        end
    end
end