class CommentsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_client 
    before_action :set_article 

    def index 
        @comments = @article.comments
        @newcomment = Comment.new
    end

    def new  
        @comment = Comment.new
    end

    def create 
        @comment = @article.comments.create(comments_params)
        if @comment.save 
            flash[:notice]='Comment Created'
        else
            flash[:notice] = 'Error creating comment'
        end
    end

    def delete 
        @comment = Comment.find(params[:id])
        @comment.destroy 
    end

    private 
    def comments_params
        params.require(:comment).permit(:body).merge(user_id: current_user.id)
    end

    def set_client 
        @client = Client.find_by(sub_domain: params[:client_id])
    end

    def set_article 
        @article = Article.find(params[:article_id])
    end
end
