FactoryBot.define do
    factory :article do
        title { Faker::Company.name }
        body { Faker::Lorem.sentence(word_count: 10) }
        category_id {create(:category).id}
        client_id {create(:client).id}
        client_user_id {create(:client_user).id}
    end
end