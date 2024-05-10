require 'rails_helper'

RSpec.describe "Likes", type: :request do
  describe "POST /like" do

    let(:client) { FactoryBot.create(:client) }
    let(:article) { FactoryBot.create(:article) }
    let(:user) { FactoryBot.create(:user) }

    before(:each) do
      sign_in user
    end

    it 'is a successful request & active-user likes the given article' do
      post like_article_path(client.sub_domain, article.id)
      is_liked_by_user = Like.find_by(user: user, article: article).present?

      expect(is_liked_by_user).to be(true)
    end

    it 'is a successful request & active-user likes the given article' do
      post like_article_path(client.sub_domain, article.id)
      is_liked_by_user = Like.find_by(user: user, article: article)

      expect(is_liked_by_user.status).to be(false)
    end
    
  end
end
