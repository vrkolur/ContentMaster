require 'rails_helper'

RSpec.describe ClientUser, type: :model do
  it "is valid" do 
    client_user = FactoryBot.create(:client_user)
    expect(client_user).to be_valid
  end

  describe "associatons" do
    it "user must exist" do 
      client_user = FactoryBot.build(:client_user,user_id: nil)
      expect(client_user).not_to be_valid
      expect(client_user.errors.full_messages).to include("User must exist")
    end

    it "client must exist" do 
      client_user = FactoryBot.build(:client_user,client_id: nil)
      expect(client_user).not_to be_valid
      expect(client_user.errors.full_messages).to include("Client must exist")
    end

    it "user_client has_many aricles" do 
      client_user = FactoryBot.create(:client_user)
      articles = FactoryBot.create_list(:article, 3, client_user_id: client_user.id)
      expect(client_user.articles.count).to eq(3)
    end

  end

end
