module Resolvers
    class TopicSearch < Resolvers::Base
        argument :topic, String, required: true
        argument :pagination, Types::Pagination, required: false

        type [Types::TweetType], null: false
        
        def resolve(topic:, pagination:)
            return GraphQL::ExecutionError.new("Must be signed in to access this feature") unless context[:current_user]
            # cu = context[:current_user]
            return GraphQL::ExecutionError.new("You must provide a keyword! No empty string searches") if topic == ""

            Tweet.where("content like ?", "%#{topic}%" ).offset(pagination[0] * 10).limit(pagination[1])
        end
    end
end