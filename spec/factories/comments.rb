FactoryBot.define do
    factory :comment do
        body { Faker::Lorem.sentence(word_count: 10) }
        user_id { create(:user).id }
        article_id {create(:article).id }
    end
end