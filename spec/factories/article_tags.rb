FactoryBot.define do
    factory :article_tag do
        tag_id { create(:tag).id }
        article_id { create(:article).id }
    end
end