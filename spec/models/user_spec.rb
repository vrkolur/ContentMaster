require 'rails_helper'

RSpec.describe User, type: :model do
  it 'Test test' do 
    expect(true).to be(true)
  end

  it 'is a valid user' do 
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  describe "validations" do
    it "name can't be blank" do 
      user = FactoryBot.build(:user,name: nil)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it "email cannot be blank" do 
      user = FactoryBot.build(:user,email: nil)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it "password canot be blank" do 
      user = FactoryBot.build(:user, password: nil)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end
  end

  describe "associations" do 
    it "role is not present" do 
      user = FactoryBot.build(:user,role_id: 100)
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Role must exist")
    end
  end

end
