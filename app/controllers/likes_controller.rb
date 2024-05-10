class LikesController < ApplicationController 
    before_action :set_article

    def like 
        @like = Services::LikesService.new(user: current_user,article: @article).like
    end

    def dislike 
        @like = Services::LikesService.new(user: current_user,article: @article).dislike
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end
end