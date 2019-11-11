module Resolvers
    class SearchFollowingFor < Resolvers::CurrentUserCheck
        argument :keyword, String, required: true
        argument :pagination, Types::Pagination, required: false
        argument :ownership_filter, Types::OwnershipFilter, required: false

        type [Types::TweetType], null: false

        def resolve(pagination: [0, 10], keyword:, ownership_filter:)
          self.cuc
            return GraphQL::ExecutionError.new("You must provide a keyword! No empty string searches") if keyword == ""
            case
            when ownership_filter ==  "self"
                # self only
                return Tweet.where(user_id: me.id).where("content like ? ", "%#{keyword}%")&.order(id: "desc").offset(pagination[0]).limit(pagination[1])
            when ownership_filter == "following"
                # theirs
                return Tweet.where(user_id: [me.following.select(:id)]).where("content like ? ", "%#{keyword}%")&.order(id: "desc").offset(pagination[0]).limit(pagination[1])
            else
                # all
                return Tweet.where(user_id: [ me.id, me.following.select(:id)].flatten).where("content like ?", "%#{keyword}%")&.order(id: "desc").offset(pagination[0]).limit(pagination[1])
            end
          rescue ActiveRecord::RecordInvalid => e
            GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
        end
    end
end