module ClientUsersHelper
    def client_user_form_errors(user) 
        if user.errors.any?
            yield 
        end
    end
    def user_client_admin(user)
        if user.role.title=='ClientAdmin'
            yield 
        end
    end
end