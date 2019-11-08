module Types
    class UserArgs < BaseInputObject
        description "Universal User Arguments"
        graphql_name "UUA"
        argument :username, String, required: false
        argument :email, String, required: false
        argument :password, String, required: false
        argument :bio, String, required: false
    end
end