module ApplicationHelper

    def user_logged_in 
        if current_user 
            yield
        end
    end

    def user_admin(user)
        if user.role.title=='Admin'
            yield 
        end
    end

    def user_client_admin(user)
        if user.role.title == 'ClientAdmin'
            yield 
        end
    end

    def user_client_author(user)
        if user.role.title == 'Author'
            yield 
        end
    end

    def user_reader(user) 
        if user.role.title == "Reader"
            yield 
        end
    end

end
