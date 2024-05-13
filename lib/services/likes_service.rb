module Services 
    class LikesService 

        def initialize(user: nil, article: nil)
            @user = user 
            @article = article
        end
        
        def like 
            @like = @user.likes.find_by(article_id: @article.id)
            if @like 
                if @like.status
                    @like.destroy
                else 
                    @like.update(status: true)
                end
            else 
                @like = @user.likes.create(article: @article,status: true) 
            end
        end

        def dislike 
            @like = @user.likes.find_by(article_id: @article.id)
            if @like 
                if @like.status 
                    @like.update(status: false)
                else 
                    @like.destroy
                end
            else 
                @like = @user.likes.create(article: @article,status: false)
            end
        end

    end 
end