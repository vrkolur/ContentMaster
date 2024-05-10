require 'rails_helper'

RSpec.describe ArticleTag, type: :model do
  it "valid article_tag" do 
    article_tag = FactoryBot.create(:article_tag)
    expect(article_tag).to be_valid
  end

  describe "associations" do 
    it "belongs to tag" do 
      article_tag = FactoryBot.build(:article_tag, tag_id: nil)
      expect(article_tag).not_to be_valid
      expect(article_tag.errors.full_messages).to include("Tag must exist")
    end

    it "belongs to article" do 
      article_tag = FactoryBot.build(:article_tag, article_id: nil)
      expect(article_tag).not_to be_valid
      expect(article_tag.errors.full_messages).to include("Article must exist")
    end
  end
end
