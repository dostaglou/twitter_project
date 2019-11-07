module Resolvers
    class TweetStats < Resolvers::Base
        argument :user_id, ID, required: false

        def resolve(user_id: nil)
        
        case 
        when user_id == nil
            sql = <<-SQL 
            select date(created_at), count(*) from tweets 
            group by date(created_at) limit 7;
            SQL
        else 
            sql = <<-SQL 
            select date(created_at), count(*) from tweets 
            where user_id = #{user_id}
            group by date(created_at) limit 7
            SQL
        end
        
        records_array = ActiveRecord::Base.connection.execute(sql)
        # records_array.map! { |hsh| Tweet.find(hsh["id"]) }


        end
    end
end


