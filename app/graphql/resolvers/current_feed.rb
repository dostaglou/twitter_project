module Resolvers
    class CurrentFeed < Resolvers::Base
        
        argument :limit, Integer, required: false
        
        type [Types::TweetType], null: false


        def resolve(limit: 10)
            cu = context[:current_user]

            sql = <<-SQL
                select * from tweets
                where user_id in (Select following_id from follows where follower_id = #{cu.id}) 
                order by created_at DESC
                limit #{limit}
            SQL
            records_array = ActiveRecord::Base.connection.execute(sql)
            records_array.map! { |hsh| Tweet.find(hsh["id"]) }
        end
    end
end