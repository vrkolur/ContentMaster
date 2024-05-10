require 'rails_helper'

RSpec.describe Comment, type: :model do
  
  it "is valid" do 
    comment = FactoryBot.create(:comment)
    expect(comment).to be_valid
  end

  describe "validation" do 
    it "body cannot be blank" do 
      comment = FactoryBot.build(:comment, body: nil)
      expect(comment).not_to be_valid
      expect(comment.errors.full_messages).to include("Body can't be blank")
    end

    it "user must exist to create comment" do 
      comment = FactoryBot.build(:comment, user_id: nil)
      expect(comment).not_to be_valid
      expect(comment.errors.full_messages).to include("User must exist")
    end

    it "article must exist to create comment" do 
      comment = FactoryBot.build(:comment, article_id: nil)
      expect(comment).not_to be_valid
      expect(comment.errors.full_messages).to include("Article must exist")
    end

  end
end
