require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'Hello Test' do
    expect(true).to be(true)
  end 

  it 'should be valid' do 
    tag = FactoryBot.create(:tag)
    expect(tag).to be_valid
  end

  it 'should have a name' do 
    tag = FactoryBot.build(:tag, name:nil)
    expect(tag).not_to be_valid
    expect(tag.errors.full_messages).to include("Name can't be blank")
  end

  it 'should not have same names' do 
    tag1 = FactoryBot.create(:tag)
    tag2 = FactoryBot.build(:tag, name:tag1.name)
    expect(tag2).not_to be_valid
    expect(tag2.errors.full_messages).to include("Name has already been taken")
  end
end
