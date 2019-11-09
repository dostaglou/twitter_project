# module Resolvers
#     class TopicSearch < Resolvers::Base
#         argument :topic, String, required: true
#         argument :pagination, Types::PaginationType, required: false

#         resolve(topic:, pagination:)
#             Tweet.where("content like ?": topic ).offset([pagination:offset] * 0).limit(pagination[:limit]
#         end
#     end
# end