module Resolvers
    class CurrentFeed < Resolvers::Base
        argument :limit, Integer, required: false
        type [Types::TweetType], null: false
        def resolve(limit: 10)
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            cu = context[:current_user]
            return GraphQL::ExecutionError.new("Limit must be greater than zero (0)") if limit < 1 || limit >= 101
            return GraphQL::ExecutionError.new("Limit must be less than 101") if !limit.in?(1..100)
            sql = <<-SQL
                select * from tweets
                where user_id in (Select following_id from follows where follower_id = #{cu.id}) 
                order by created_at DESC
                limit #{limit}
            SQL
            # Tweet.where(user_id: cu.following.select(:following_id).to_sql).group().order().limit
            records_array = ActiveRecord::Base.connection.execute(sql)
            records_array.map! { |hsh| Tweet.find(hsh["id"]) }
        end
    end
end