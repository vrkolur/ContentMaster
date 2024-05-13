class ArticleAssignmentsController < ApplicationController
    before_action :authenticate_user!
    before_action :check_client
    before_action :check_admin

    def new 
        @authors = Services::AuthorsService.new(client: @client).authors_list 
    end

    def create 
        @author = User.find_by(id: params[:author_id])
        msg = "Hey you are supposed to create a artile with title:#{params[:title]} and Category: #{Category.find_by(id: params[:category_id]).title} "
        @notification = Message.create(sender:current_user, reciever:@author,msg: msg)
        if @notification.save 
            flash[:notice] = 'Article Assigned Successfully'
            redirect_to new_article_assignment_path(client_id: @client.sub_domain)
        else 
            flash[:notice] = 'Error Occured please try again'
            render :new
        end
    end


    private 

    def check_admin 
        client_user = ClientUser.find_by(user: current_user) if current_user && current_user.role.title == 'ClientAdmin'
        # @client = Client.find_by(sub_domain: params[:client_id])
        unless client_user&.client == @client 
            redirect_to articles_path(client_id: client_user&.client&.sub_domain)
        end
    end

    def check_client
        @client =  Client.find_by(sub_domain: params[:client_id])
        unless @client
          redirect_to root_path
        end
    end
end
