class LikesController < ApplicationController 
    skip_before_action :verify_authenticity_token
    before_action :set_article

    def like 
        @like = Services::LikesService.new(user: current_user,article: @article).like
    end

    def dislike 
        @like = Services::LikesService.new(user: current_user,article: @article).dislike
    end

    def set_article
        @article = Article.find_by(id: params[:id])
    end
end