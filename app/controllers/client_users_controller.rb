class ClientUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin?
    before_action :set_client
    before_action :set_client_user
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def new 
        @client_user = ClientUser.new 
    end
    
    def create
        @user = User.create(client_user_params)
        if  @user.save
            @client_user = @client.client_users.create(user: @user)
            redirect_to clients_path
            flash[:notice]= 'Client User Created'
        else 
            render :new, status: :unprocessable_entity 
        end
    end

    def index 
        @authors = Services::AuthorsService.new(client: @client).authors_list 
    end

    def destroy 
        @client_user.destroy
    end

    def download 
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

    def set_client_user 
        @client_user = ClientUser.find_by(id: params[:id])
    end

    def client_user_params 
        if current_user.role.title=='Admin'
            return params.require(:client_user).permit(:name,:email,:password,:password_confirmation).merge(role_id: 2)
        end
        params.require(:client_user).permit(:name,:email,:password,:password_confirmation,:role_id)
    end
end
