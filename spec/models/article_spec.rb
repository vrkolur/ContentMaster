require 'rails_helper'

RSpec.describe Article, type: :model do

  it "valid article" do 
    article = FactoryBot.create(:article)
    expect(article).to be_valid
  end

  describe "validations" do 
    it "title cannot be blank" do 
      article = FactoryBot.build(:article, title: nil)
      expect(article).not_to be_valid
      expect(article.errors.full_messages).to include("Title can't be blank")
    end

    it "title cannot be blank" do 
      article = FactoryBot.build(:article, body: nil)
      expect(article).not_to be_valid
      expect(article.errors.full_messages).to include("Body can't be blank")
    end
  end

  describe "associations" do 
    it "Category must exist" do
      article = FactoryBot.build(:article, category_id: nil)
      expect(article).not_to be_valid
      expect(article.errors.full_messages).to include("Category must exist")
    end

    it "client must exist" do
      article = FactoryBot.build(:article, client_id: nil)
      expect(article).not_to be_valid
      expect(article.errors.full_messages).to include("Client must exist")
    end

    it "clent_user must exist" do
      article = FactoryBot.build(:article, client_user: nil)
      expect(article).not_to be_valid
      expect(article.errors.full_messages).to include("Client user must exist")
    end

    it "article has_many tags" do 
      article = FactoryBot.create(:article)
      article_tags = FactoryBot.create_list(:article_tag,3, article_id: article.id)
      expect(article.article_tags.count).to eq(3)
    end

    it "article has_many comments" do 
      article = FactoryBot.create(:article)
      comments = FactoryBot.create_list(:comment, 4, article_id: article.id)
      expect(article.comments.count).to eq(4)
    end

  end
end
