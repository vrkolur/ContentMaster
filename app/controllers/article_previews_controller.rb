class ArticlePreviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client 
    before_action :check_admin
    before_action :set_article, except: :preview_articles
    skip_before_action :verify_authenticity_token, only: [:publish_article, :reject_article]

    def preview_articles
        @articles = @client.articles.where(status: false) 
    end

    def publish_article
        @article.update(status: true)
    end

    def reject_article
        Services::RejectArticleService.new(article:@article,current_user: current_user).reject_article
    end


    private 

    def set_client 
        @client = Client.find_by(sub_domain: params[:client_id])
        if @client.nil?
            redirect_to root_path
        end
    end

    def set_article
        @article = Article.find_by(id: params[:article_id])
    end

    def check_admin 
        client_user = ClientUser.find_by(user: current_user)
        unless client_user.client == @client 
            redirect_to articles_path(client_id: client_user.client.sub_domain)
        end
    end

end
