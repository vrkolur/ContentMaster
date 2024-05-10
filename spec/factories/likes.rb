FactoryBot.define do
    factory :like do
        user_id { create(:user).id }
        article_id {create(:article).id }
        status {Faker::Boolean.boolean}
    end
end