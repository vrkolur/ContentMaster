class ArticlePreviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client 
    before_action :check_admin
    before_action :set_article, except: [:preview_articles, :all_notifications]
    skip_before_action :verify_authenticity_token, only: [:publish_article_new, :reject_article]

    def preview_articles
        @articles = @client.articles.where(status: false) 
    end

    def publish_article_new 
        @article.update(status: true)
    end

    def reject_article
        byebug
        @author = User.find_by(id: @article.client_user.user_id)
        msg = "Hey your article with title: #{params[:title]} and Category: #{params[:category]} has been rejected and destroyed by your Admin"
        @notification = Message.create(sender:current_user, reciever:@author, msg: msg)
        @article.destroy
    end


    private 

    def set_client 
        @client = Client.find_by(sub_domain: params[:client_id])
        unless @client
            redirect_to root_path
        end
    end

    def set_article
        @article = Article.find(params[:id])
        unless @article 
            @article = Article.find_by(id: params[:article_id])
        end
    end

    def check_admin 
        byebug
        client_user = ClientUser.find_by(user: current_user)
        unless client_user.client == @client 
            redirect_to articles_path(client_id: client_user.client.sub_domain)
        end
    end

end
