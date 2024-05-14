require 'rails_helper'

RSpec.describe "ArticlePreviews", type: :request do
  describe "GET /index" do
    let(:role) {FactoryBot.create(:role,title:"ClientAdmin")}
    let(:user) {FactoryBot.create(:user,role_id: role.id)}
    let (:client) {FactoryBot.create(:client)}
    let(:article) {FactoryBot.create(:article,client_id: client.id)}
    

    
    it 'should redirect to the preview articles page' do 
      client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
      sign_in client_user.user
      get review_articles_path(client_id: client.sub_domain)
      expect(response).to have_http_status(:success)
      expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/review_articles")
    end
    
    it 'should publish the article by setting the status true' do 
      user1 = FactoryBot.create(:user,role_id: role.id)
      client_user = FactoryBot.create(:client_user, user_id: user1.id,client_id: client.id)
      article1 = FactoryBot.create(:article,client_id: client.id)
      sign_in client_user.user
      post article_approve_article_path(client_id: client.sub_domain, article_id: article1.id)
      expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/articles/#{article1.id}/approve_article")
      expect(response).to have_http_status(:success)
    end
    
    it 'should reject the article and destroy the article' do 
      client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
      sign_in client_user.user
      post "/#{client.sub_domain}/articles/#{article.id}/reject_article"
      expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/articles/#{article.id}/reject_article")
    end
    
    it 'redirect to home page if client not found' do 
      client_user = FactoryBot.create(:client_user)
      sign_in client_user.user
      post "/#{"FakeClient"}/articles/#{article.id}/reject_article"
      expect(response).to have_http_status(302)
    end


  end
end
