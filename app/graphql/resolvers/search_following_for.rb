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
                # mine
                sql = <<-SQL
                select * from tweets
                where user_id is #{cu.id}
                and content like '%#{keyword}%'
                order by created_at DESC
                limit #{limit}
                SQL
            when others_only == true
                # theirs
                sql = <<-SQL
                select * from tweets
                where user_id in (Select following_id from follows where follower_id = #{cu.id})
                and not user_id = #{ cu.id }
                and content like '%#{keyword}%'
                order by created_at DESC
                limit #{limit} 
                SQL
            else
                # all
                sql = <<-SQL
                    select * from tweets
                    where user_id in (Select following_id from follows where follower_id = #{cu.id})
                    and content like '%#{keyword}%'
                    order by created_at DESC
                    limit #{limit}
                SQL
            end
            
            records_array = ActiveRecord::Base.connection.execute(sql)
            records_array.map! { |hsh| Tweet.find(hsh["id"]) }
        end
    end
end