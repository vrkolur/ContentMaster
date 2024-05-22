class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client
    skip_before_action :verify_authenticity_token, only: :mark_as_read


    def all_messages
        @messages = Message.where(reciever_id: current_user.id, status: false)
    end

    def mark_as_read 
        @message = Message.find(params[:id]).update(status: true)
    end

    private 
    def set_client
        @client = Client.find_by(sub_domain: params[:client_id])
        if ClientUser.find_by(user: current_user).client != @client
            redirect_to client_articles_path(client_id: ClientUser.find_by(user: current_user).client.sub_domain)
        end
    end
end
