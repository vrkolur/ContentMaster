require 'rails_helper'

RSpec.describe Like, type: :model do
  it "is a valid like" do 
    like = FactoryBot.create(:like)
    expect(like).to be_valid
  end

  describe "validation" do 

    it "user must exist to like" do 
      like = FactoryBot.build(:like, user_id: nil)
      expect(like).not_to be_valid
      expect(like.errors.full_messages).to include("User must exist")
    end

    it "article must exist to create like" do 
      like = FactoryBot.build(:like, article_id: nil)
      expect(like).not_to be_valid
      expect(like.errors.full_messages).to include("Article must exist")
    end

  end

end
