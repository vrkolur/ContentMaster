class ClientsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client
    before_action :check_admin , only: %i[ show create index edit update destroy change_client_active_status ]
    skip_before_action :verify_authenticity_token, only: [:change_client_active_status,:destroy,:update_sub_domain]

    
    def index
        @client = Client.new
        @clients = Client.all[1..-1]
    end

    def create 
        @client = Client.new(client_params)
        if @client.save 
            redirect_to clients_path
            flash[:notice]= 'Client created'
        else 
            render :new
        end
    end 
    
    def edit 
        # byebug
    end 

    def show 

    end

    def update 
        # byebug
        unless @client
            @client = Client.find_by(sub_domain: params[:id])
        end
        @client.slug = params[:sub_domain]
        if @client.update(client_params)
            flash[:notice] = "Client Updated"
            redirect_to clients_path
        else 
            render :edit
        end
    end

    def edit_sub_domain
        
    end

    def update_sub_domain 
        # byebug
        @client.update(slug: params[:sub_domain])
        if @client.update(sub_domain: params[:sub_domain]) 
            flash[:alert] = 'Sub Domain Updated'
            redirect_to articles_path(client_id: @client.sub_domain)
        end
    end

    def change_client_active_status
        active_status = @client.is_active
        @client.update(is_active:  !active_status)
    end

    def destroy 
        # byebug
        @client.destroy           
    end


    private 

    def client_params 
        params.require(:client).permit(:name,:background_image,:sub_domain,:is_active)
    end

    def set_client 
        @client = Client.friendly.find_by(id: params[:id])
        unless @client 
            @client = Client.find_by(sub_domain: params[:id])
        end
        # byebug
    end

    def check_admin 
        unless current_user.email == 'admin@email.com'
            redirect_to root_path
        end 
    end

end
