class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        if resource.role.title == 'Admin'
            clients_path
        else 
            client = Client.find_by(sub_domain: params[:client_id])
            client_articles_path(client_id: client.sub_domain)
        end
    end
end
