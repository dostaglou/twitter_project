module Resolvers
    class FindUser < Resolvers::Base
        argument :username, String, required: true
        argument :pagination, Types::Pagination, required: false
        type [Types::UserType], null: true

        def resolve(username:, pagination: [0,20])
            User.where("username like ?", "%#{username}%").offset(pagination[0]).limit(pagination[1])
        end
    end
end