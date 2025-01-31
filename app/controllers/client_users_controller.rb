class ClientUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client
    before_action :check_admin?
    before_action :set_client_user
    skip_before_action :verify_authenticity_token, only: [:destroy]

    def new 
        @client_user = ClientUser.includes([:user]).new 
    end
    
    def create
        @user = User.create(client_user_params)
        if  @user.save
            @client_user = @client.client_users.create(user: @user)
            flash[:notice]= 'Client User Created'
            redirect_to client_articles_path(client_id: @client.sub_domain)
        else 
            flash[:alert] = "Error Password does not match or Email Taken"
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
        authors_pdf = Services::AuthorsDownloadService.new(client: @client).download
        unless params[:preview].present?
            send_data(authors_pdf.render,  filename: "#{@client.name}.pdf", type: "authors/pdf")
        end
    end

    private 

    def set_client 
        @client = Client.find_by(sub_domain: params[:client_id])
    end

    def check_admin? 
        unless( current_user.role.title=='Admin' || current_user.role.title=='ClientAdmin' ) && ClientUser.find_by(user: current_user).client == @client
            redirect_to client_articles_path(client_id: ClientUser.find_by(user: current_user).client.sub_domain)
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
