module Resolvers
    class SearchFollowingFor < Resolvers::Base
        
        argument :limit, Integer, required: false
        argument :self_only, Boolean, required: true, default_value: false
        argument :others_only, Boolean, required: true, default_value: false
        argument :keyword, String, required: true
        type [Types::TweetType], null: false

        def resolve(limit: 10, self_only:, others_only:, keyword:)
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            cu = context[:current_user]
            return GraphQL::ExecutionError.new("You must provide a keyword! No empty string searches") if keyword == ""
            return GraphQL::ExecutionError.new("Limit must be greater than zero (0)") if limit < 1
            return GraphQL::ExecutionError.new("You may not set both SELF and OTHERs true at the same time") if self_only == true && others_only == true
            case
            when self_only ==  true
                # self only
                return Tweet.where(user_id: cu.id).where("content like ? ", "%#{keyword}%").limit(limit)
            when others_only == true
                # theirs
                return Tweet.where(user_id: [cu.following.select(:id)]).where("content like ? ", "%#{keyword}%").limit(limit)
            else
                # all
                value = cu.following.select(:id)
                # byebug
                return Tweet.where(user_id: [ cu.id, cu.following.select(:id)].flatten).where("content like ?", "%#{keyword}%").limit(limit)
            end

        end
    end
end