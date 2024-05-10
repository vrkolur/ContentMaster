require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "validations" do 
    it "is valid" do 
      category = FactoryBot.create(:category)
      expect(category).to be_valid
    end

    it "title cannot be blank" do 
      category = FactoryBot.build(:category,title: nil)
      expect(category).not_to be_valid
      expect(category.errors.full_messages).to include("Title can't be blank")
    end

    it "title cannot be blank" do 
      category1 = FactoryBot.create(:category)
      category2 = FactoryBot.build(:category, title: category1.title)
      expect(category2).not_to be_valid
      expect(category2.errors.full_messages).to include("Title has already been taken")
    end

  end

  describe "associations" do 

  end
end
