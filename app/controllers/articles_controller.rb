class ArticlesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_client
    before_action :check_active 
    before_action :set_article, only: [:new, :index, :show, :create, :edit, :update, :download]
    skip_before_action :verify_authenticity_token, only: [:like, :dislike, :publish_article]

    def new 
        @tags = Tag.all
        # byebug
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
        # byebug
        @article = @client.articles.create(article_params)
        byebug
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
        # byebug
        if @article.save
            redirect_to articles_path(client_id: @client.sub_domain)
        else 
            render :edit, status: :unprocessable_entity
        end  
    end

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

    def review_article 
        @articles = Article.all.where(status: false)
        # byebug
    end

    def publish_article 
        # byebug
        @article.update(status: true)
    end

    def download
        article_pdf = Prawn::Document.new
        article_pdf.text  @article.title
        image_attachment = @article.image
        if image_attachment.image?
            image_data = image_attachment.download
            article_pdf.move_down 10
            article_pdf.image StringIO.new(image_data), fit: [200, 200], position: :center
        end
        article_pdf.text @article.category.title
        article_pdf.text @article.body
        if params[:preview].present?
            send_data(article_pdf.render, filename: "#{@article.title}.pdf", type: "application/pdf", disposition: 'inline')
        else
            send_data(appointment_pdf.render,  filename: "#{@article.title}.pdf", type: "application/pdf")
        end
    end

    private 

    def set_client
        @client = Client.find_by(sub_domain: params[:client_id])
        # byebug
        unless @client 
            @article = Article.find_by(id: params[:id])
            @client = Client.find_by(id: @article.client.id)
        end
    end

    def article_params
        params.require(:article).permit(:title, :heading, :body, :category_id, :image,  tag_ids: []).merge(client_user_id: current_user.id)
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

