class LikesController < ApplicationController 

    def like 
        @like = current_user.likes.find_by(article_id: @article.id)
        if @like 
            if @like.status
                @like.destroy
            else 
                @like.update(status: true)
            end
        else 
            @like = current_user.likes.create(article: @article,status: true) 
        end
    end

    def dislike 
        @like = current_user.likes.find_by(article_id: @article.id)
        if @like 
            if @like.status 
                @like.update(status: false)
            else 
                @like.destroy
            end
        else 
            @like = current_user.likes.create(article: @article,status: false)
        end
    end
end