class ArticleAssignmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin

    def new 
        @authors = Services::AuthorsService.new(client: @client).authors_list 
    end

    def create 
        # byebug
        @author = User.find_by(id: params[:author_id])
        # notification = AssignedNotifier.with(record: @author, message: "Hey You are supposed to create a Article with the following Title: #{params[:title]} Category: #{params[:category]}").deliver(current_user)
        # ActionCable.server.broadcast("assigned_notifier_channel", notification)
    end


    private 

    def check_admin 
        client_user = ClientUser.find_by(user: current_user) if current_user && current_user.role.title == 'ClientAdmin'
        @client = Client.find_by(sub_domain: params[:client_id])
        unless client_user&.client == @client 
            redirect_to articles_path(client_id: client_user.client.sub_domain)
        end
    end
end
