require 'rails_helper'

RSpec.describe Client, type: :model do
  it "Hello" do 
    expect(false).to be(false)
  end

  it 'has valid details' do
    client = FactoryBot.build(:client)
    expect(client).to be_valid
  end

  it 'is not active' do 
    client = FactoryBot.build(:client,is_active: false)
    expect(client).to be_valid
  end
  
  it 'is active' do 
    client = FactoryBot.build(:client,is_active: true)
    expect(client).to be_valid
  end

  describe 'validations' do 
    it 'name cannot be null' do 
      client = FactoryBot.build(:client,name: nil)
      expect(client).not_to be_valid
    end

    it 'sub_domain cannot be null' do 
      client = FactoryBot.build(:client,sub_domain: nil)
      expect(client).not_to be_valid
    end

    it 'name cannot be the same' do 
      client1 = FactoryBot.create(:client)
      test_client = FactoryBot.build(:client, name: client1.name)
      expect(test_client).not_to be_valid
      expect(test_client.errors.full_messages).to include("Name has already been taken")
    end

    it 'Subdomain cannot be the same' do 
      client1 = FactoryBot.create(:client)
      client2 = FactoryBot.build(:client, sub_domain: client1.sub_domain)
      expect(client2).not_to be_valid
      expect(client2.errors.full_messages).to include("Sub domain has already been taken")
    end
    
  end

end
