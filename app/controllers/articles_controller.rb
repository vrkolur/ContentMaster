class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_client
    before_action :check_active 
    before_action :check_admin, except: [:index, :show, :download]
    # before_action :set_article, only: [ :index, :show, :create, :edit, :update, :download]
    before_action :set_article, except: [:new, ]

    def new 
        @tags = Tag.all
        @article = Article.new
    end

    def index 
        @q = @client.articles.where(status: true).ransack(params[:q])
        @articles = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 5)
    end

    def show
        @article.update(view_count: @article.view_count+1)
        @comments = @article.comments.order(created_at: :desc)
    end

    def create 
        @article = @client.articles.create(article_params.merge(client_user_id: ClientUser.find_by(user: current_user).id))
        if @article.save 
            redirect_to client_articles_path
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
            redirect_to client_articles_path(client_id: @client.sub_domain)
        else 
            render :edit, status: :unprocessable_entity
        end  
    end

    def download
        article_pdf = Services::ArticleDownloadService.new(article: @article).download
        if params[:preview].present?
            send_data(article_pdf.render, filename: "#{@article.title}.pdf", type: "application/pdf", disposition: 'inline')
        else
            send_data(article_pdf.render,  filename: "#{@article.title}.pdf", type: "application/pdf")
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
        params.require(:article).permit(:title, :heading, :body, :category_id, :image,  tag_ids: [])
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