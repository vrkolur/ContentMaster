class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client

    def all_messages
        @messages = Message.where(reciever_id: current_user.id,status: false)
        if @messages
            render partial: 'messages/message', locals: { messages: @messages }
        end
    end

    def mark_as_read 
        @message = Message.find(params[:id]).update(status: true)
    end

    private 
    def set_client
        @client = Client.find_by(sub_domain: params[:client_id])
    end
end
