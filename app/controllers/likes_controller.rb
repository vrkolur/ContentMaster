class LikesController < ApplicationController 

    def like 
        @like = Services::LikesService.new(user: current_user,article: @article).like
    end

    def dislike 
        @like = Services::LikesService.new(user: current_user,article: @article).dislike
    end
end