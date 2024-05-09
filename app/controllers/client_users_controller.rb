class ClientUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client
    before_action :check_admin?

    def new 
        @client_user = ClientUser.new 
    end
    
    def create
        @user = User.create(client_user_params)
        @client_user = @client.client_users.create(user: @user)
        byebug
        if  @client_user.save
            redirect_to clients_path
            flash[:notice]= 'Client Admin Created'
        else 
            render :new, status: :unprocessable_entity 
        end
    end

    private 

    def set_client 
        @client = Client.find_by(sub_domain: params[:client_id])
    end

    def check_admin? 
        unless current_user.role.title=='Admin' || current_user.role.title=='ClientAdmin'
            redirect_to root_path
        end
    end

    def client_user_params 
        if current_user.role.title=='Admin'
            return params.require(:client_user).permit(:name,:email,:password,:password_confirmation).merge(role_id: 2)
        end
        params.require(:client_user).permit(:name,:email,:password,:password_confirmation,:role_id)
    end
end
