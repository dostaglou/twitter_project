module Resolvers
    class TweetStats < Resolvers::Base
        argument :user_id, ID, required: false
        type GraphQL::Types::JSON, null: false
        def resolve(user_id: nil)
            case 
            when user_id != nil
                Tweet.where(user_id: user_id).group("date(created_at)").where(created_at: (Date.today - 1.week)..Date.today).count
            else 
                Tweet.group("date(created_at)").where(created_at: (Date.today - 1.week)..Date.today).count
            end
        end
    end
end


#