require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'Role test' do 
    expect(false).to be(false)
  end

  it 'Should be valid' do 
    role =  FactoryBot.build(:role)
    expect(role).to be_valid
  end

  it 'title cannot be blank' do 
    role = FactoryBot.build(:role,title: nil)
    expect(role).not_to be_valid
  end

  it 'title is already taken' do 
    role1 = FactoryBot.create(:role)
    role2 = FactoryBot.build(:role, title:role1.title)
    expect(role2).not_to be_valid 
    expect(role2.errors.full_messages).to include("Title has already been taken")
  end

  describe 'associations' do 
    it 'has_many users' do
    role = FactoryBot.create(:role)
    users = FactoryBot.create_list(:user, 3, role: role)
    expect(role.users.count).to eq(3)
    end

    it 'has_many users' do
    role = FactoryBot.create(:role)
    users = FactoryBot.create_list(:user, 12, role: role)
    expect(role.users.count).not_to eq(3)
    end
  end

end
