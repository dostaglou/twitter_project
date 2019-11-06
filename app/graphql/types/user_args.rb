module Types
    class UserArgs < BaseInputObject
        argument :username, String, required: false
        argument :email, String, required: false
        argument :password, String, required: false
        argument :bio, String, required: false
    end
end