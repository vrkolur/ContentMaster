module ClientsHelper

    def client_form_errors(client) 
        if client && client.errors.any?
            yield
        end
    end

    def client_image_attached(client)
        if client.background_image.attached? 
            yield 
        end
    end

    def client_admin_empty(client)
        if client.client_users.empty? 
            yield
        end
    end

    def current_user_client_admin(user)
        if user.role.title=='ClientAdmin'
            yield
        end
    end

    def is_client_active(client)
        if client.is_active
            yield 
        end
    end

    def is_client_inactive(client)
        unless client.is_active 
            yield
        end
    end

end
