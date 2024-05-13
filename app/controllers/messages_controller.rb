class MessagesController < ApplicationController
    before_action :set_client

    def all_messages
        @messages = Message.where(reciever_id: current_user.id,status: false)
        if @messages
            render partial: 'messages/message', locals: { messages: @messages }
        end
    end

    def mark_as_read 
        byebug
        @message = Message.find(params[:id])
        @message.update(status: true)
    end

    private 
end
