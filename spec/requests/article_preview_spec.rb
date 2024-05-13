require 'rails_helper'

RSpec.describe "ArticlePreviews", type: :request do
  describe "GET /index" do
    let(:role) {FactoryBot.create(:role,title:"ClientAdmin")}
    let(:user) {FactoryBot.create(:user,role_id: role.id)}
    let (:client) {FactoryBot.create(:client)}
    let(:article) {FactoryBot.create(:article,client_id: client.id)}
    

    before(:each) do
      sign_in user
    end

    it 'should redirect to the preview articles page' do 
      client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
      get review_articles_new_path(client_id: client.sub_domain)
      expect(response).to have_http_status(:success)
      expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/review_articles_new")
    end
    
    # it 'should publish the article by setting the status true' do 
    #   client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
    #   post "/#{client.sub_domain}/articles/#{article.id}/approve_article_new"
    #   expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/articles/#{article.id}/approve_article_new")
    # end
    
    # it 'should reject the article and destroy the article' do 
    #   client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
    #   post "/#{client.sub_domain}/articles/#{article.id}/reject_article"
    #   expect(response.request.url).to eq("http://www.example.com/#{client.sub_domain}/articles/#{article.id}/reject_article")
    # end
    
    # it 'should display all the notifications ' do 
    #   client_user = FactoryBot.create(:client_user, user_id: user.id,client_id: client.id)
      
    # end


  end
end
