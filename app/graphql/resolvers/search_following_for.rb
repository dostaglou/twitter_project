module Resolvers
    class SearchFollowingFor < Resolvers::Base
        
        argument :limit, Integer, required: false
        argument :self_only, Boolean, required: false, default_value: false
        argument :others_only, Boolean, required: false, default_value: false
        type [Types::TweetType], null: false

        def resolve(limit: 10, self_only:, others_only:)
            cu = context[:current_user]
            keyword = "Dwitter"

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