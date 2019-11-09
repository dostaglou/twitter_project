module Types
    class Pagination < BaseInputObject
        description "Universal Pagination Arguments"
        graphql_name "UPA"
        argument :offset, Integer, required: false, default_value: 0
        argument :limit, Integer, required: false, default_value: 20
        
        def prepare 
            return GraphQL::ExecutionError.new("limit must be between 1 and 50") unless (1..50).include?(limit)
            return GraphQL::ExecutionError.new("offset must be between 1 and 500") unless (1..500).include?(offset)
            [offset, limit]
        end
    end
end