class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_client
    before_action :check_active 
    # before_action :check_admin, only: [:new, :create, :edit, :update, :review_article, :publish_article]
    before_action :check_admin, except: [:index, :show, :like, :dislike, :download]
    before_action :set_article, only: [:new, :index, :show, :create, :edit, :update, :download]
    skip_before_action :verify_authenticity_token, only: [:like, :dislike, :publish_article]

    def new 
        @tags = Tag.all
        @article = Article.new
    end

    def index 
        @q = @client.articles.where(status: true).ransack(params[:q])
        @articles = @q.result(distinct: true)
    end

    def show
        @comments = @article.comments.order(created_at: :desc)
    end

    def create 
        @article = @client.articles.create(article_params)
        if @article.save 
            redirect_to articles_path
        else
            render :new, status: :unprocessable_entity 
        end
    end

    def edit 
        @tags = Tag.all
    end
    
    def update 
        @article.update(article_params)
        if @article.save
            redirect_to articles_path(client_id: @client.sub_domain)
        else 
            render :edit, status: :unprocessable_entity
        end  
    end

    def like 
        @like = Services::LikesService.new(user: current_user,article: @article).like
    end
    
    def dislike 
        @like = Services::LikesService.new(user: current_user,article: @article).dislike
    end

    def review_article 
        @articles = @client.articles.where(status: false)
    end

    def publish_article 
        @article.update(status: true)
    end

    def download
        article_pdf = Services::ArticleDownloadService.new(article: @article).download
        if params[:preview].present?
            send_data(article_pdf.render, filename: "#{@article.title}.pdf", type: "application/pdf", disposition: 'inline')
        else
            send_data(appointment_pdf.render,  filename: "#{@article.title}.pdf", type: "application/pdf")
        end
    end

    private 

    def set_client
        @client = Client.find_by(sub_domain: params[:client_id])
        unless @client 
            @article = Article.find_by(id: params[:id])
            @client = Client.find_by(id: @article.client.id)
        end
    end

    def check_admin 
        client_user = ClientUser.find_by(user: current_user)
        unless client_user.client == @client 
            redirect_to articles_path(client_id: client_user.client.sub_domain)
        end

    end

    def article_params
        params.require(:article).permit(:title, :heading, :body, :category_id, :image,  tag_ids: []).merge(client_user_id: ClientUser.find_by(user: current_user).id)
    end

    def set_article 
        @article = Article.find_by(id: params[:id])
    end

    def check_active
        unless @client.is_active
            redirect_to root_path
        end
    end
end

