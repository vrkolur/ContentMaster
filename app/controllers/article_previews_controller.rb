class ArticlePreviewsController < ApplicationController
    before_action :set_client 
    before_action :set_article, except: [:preview_articles, :all_notifications]
    skip_before_action :verify_authenticity_token, only: [:publish_article_new, :reject_article]

    def preview_articles
        @articles = @client.articles.where(status: false) 
    end

    def publish_article_new 
        @article.update(status: true)
    end

    def reject_article
        @author = User.find_by(id: @article.client_user.user_id)
        # if User.role.title=='Author'
        #     notification = AssignedNotifier.with(record: @author, message: "Hey your Article with the following Title: #{@article.title} and Category: #{@article.category.title} has been Rejected by you Admin.").deliver(current_user)
        #     ActionCable.server.broadcast("assigned_notifier_channel", notification)
        # end
        @article.destroy
    end

    def all_notifications
        byebug
        @notifications =  AssignedNotifier.where(record_id: current_user.id)
    end

    private 

    def set_client 
        @client = Client.find_by(sub_domain: params[:client_id])
    end

    def set_article
        @article = Article.find(params[:id])
    end

end
