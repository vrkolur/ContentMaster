require 'rails_helper'

RSpec.describe "Articles", type: :request do
  describe "GET /:client_id" do
    let(:role) {FactoryBot.create(:role,title: "ClientAdmin")}
    let(:client) {FactoryBot.create(:client)}
    let(:user) {FactoryBot.create(:user,role_id: role.id)}
    let(:client_user) {FactoryBot.create(:client_user,user_id: user.id,client_id: client.id)}
    let(:article1) {FactoryBot.create(:article,client_id: client.id)}

    it 'shouls display the home page showing all the publishes articles before sign_up' do 
      get client_articles_path(client_id: client.sub_domain)
      expect(response).to have_http_status(:success)
    end 
    
    
    before(:each) do
      sign_in client_user.user
    end
    
    it 'should display add the articles' do 
      get client_articles_path(client_id: client.sub_domain)
      expect(response).to have_http_status(:success)
      expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}")
    end

    it 'should display a new Article Form with tags present' do 
      get new_article_path(client_id: client.sub_domain)
      expect(response).to have_http_status(:success)
    end

    it 'should display the specific article' do 
      get article_path(client_id: client.sub_domain,id: article1.id)
      expect(response).to have_http_status(:success)
    end

    it 'should like the article ans generate a success response' do 
      post like_article_path(client_id: client, id: article1.id)
      expect(response).to have_http_status(:success)
      expect(Like.first.status).to eq(true)
    end

    it 'should destroy the like_record if liked again' do 
      like = FactoryBot.create(:like,user_id:user.id, article_id: article1.id, status:true)
      post like_article_path(client_id: client, id: article1.id)
      expect(response).to have_http_status(:success)
      expect(Like.find_by(user_id: user.id).nil?).to be(true)
    end

    it 'should destroy the like_record if disliked again' do 
      like = FactoryBot.create(:like,user_id:user.id, article_id: article1.id, status:false)
      post dislike_article_path(client_id: client, id: article1.id)
      expect(response).to have_http_status(:success)
      expect(Like.find_by(user_id: user.id).nil?).to be(true)
    end

    it 'should change the status when liked after dislike or liked after disliked' do 
      like = FactoryBot.create(:like,user_id:user.id, article_id: article1.id, status:true)
      post dislike_article_path(client_id: client, id: article1.id)
      expect(response).to have_http_status(:success)
      expect(Like.first.status).to be(false)
    end

    it 'should dislike the article and generate a success response' do 
      post dislike_article_path(client_id: client, id: article1.id)
      expect(response).to have_http_status(:success)
      expect(Like.first.status).to eq(false)
    end

    it 'should redirect to a pdf downloader pages withe the provides content' do 
      get download_article_path(client_id: client.sub_domain, id: article1.id)
      expect(response).to have_http_status(:success)
    end

    it 'should successfuylly created a article and redirect to clients_articles_path' do 
      category = FactoryBot.create(:category)
      client1 = FactoryBot.create(:client)
      post articles_path(client_id: client1.sub_domain ,
        article: {
          title: "Article_Title",
          category_id: category.id,
          body: 'Body',
        }
      )
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(articles_path(client_id: article1.client.sub_domain))
        expect(Article.first.title).to eq(article1.title)
    end

    it 'should redirect to a edit form to edit the article' do 
      article = FactoryBot.create(:article,client_id: client.id)
      get edit_article_path(client_id: client.sub_domain, id: article.id)
      expect(response).to have_http_status(:success)
    end

  end

  describe "post methods" do 
    let(:role) {FactoryBot.create(:role,title:"ClientAdmin")}
    let(:user) {FactoryBot.create(:user,role_id: role.id)}
    let(:client_user) {FactoryBot.create(:client_user, client_id: client.id, user_id: user.id)}
    let(:client) {FactoryBot.create(:client)}
    let(:category) {FactoryBot.create(:category)}
    let(:tag) {FactoryBot.create(:tag)}
    let(:article) {FactoryBot.create(:article)}
    let(:article_params1) do
      {
          title:"NewArticle",
          category_id: category.id,
          body: "Some Body"
      }
      end

    it 'should create a Article with specified title' do 
      sign_in client_user.user
      post articles_path(client_id: client.sub_domain), params: {article: article_params1}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(client_articles_path(client_id: client.sub_domain))
      expect(Article.last.title).to eq("NewArticle")
    end

    let(:article_params3) do
      {
          title:"NewArticle",
          category_id: category.id,
          body: "Some Body"
      }
      end
    
    it 'should Update the  a Article with specified title' do 
      article3 = FactoryBot.create(:article,client_id: client.id, client_user_id: client_user.id)
      sign_in client_user.user
      put article_path(client_id: client.sub_domain,id: article.id), params: {article: article_params3}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(client_articles_path(client_id: client.sub_domain))
      expect(Article.last.title).to eq("NewArticle")
    end


    let(:article_params2) do
      {
          title:"NewArticle",
          body: "Some Body"
      }
      end

    it 'should not create a Article without the category' do 
      sign_in client_user.user
      post articles_path(client_id: client.sub_domain), params: {article: article_params2}
      expect(response).to have_http_status(422)
      expect(response).to render_template("new")
    end

  end

  describe '#check_admin' do
    let(:role) {FactoryBot.create(:role, title: "ClientAdmin")}
    let(:user) {FactoryBot.create(:user,role_id: role.id)}

    it 'should get the articles page without redirecting' do 
        client = FactoryBot.create(:client)
        client1 = FactoryBot.create(:client)
        client_user = FactoryBot.create(:client_user, client_id: client1.id ,user_id: user.id)
        sign_in client_user.user
        get client_articles_path(client_id: client.sub_domain)
        expect(response).to have_http_status(:success)
    end

    it 'should redirect to his client page' do 
      client = FactoryBot.create(:client)
      client1 = FactoryBot.create(:client)
      client_user = FactoryBot.create(:client_user, client_id: client1.id ,user_id: user.id)
      sign_in client_user.user
      get new_article_path(client_id:  client.sub_domain)
      expect(response).to redirect_to("http://www.example.com/#{client1.sub_domain}/articles")
    end

    it 'should redirect to home page if client is not active' do 
      client = FactoryBot.create(:client,is_active: false)
      sign_in user 
      get new_article_path(client_id:  client.sub_domain)
      expect(response).to redirect_to("http://www.example.com/")
    end

  end
end
