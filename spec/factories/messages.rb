FactoryBot.define do
    factory :message do
        sender_id { create(:user).id }
        reciever_id { create(:user).id }
        msg { Faker::Lorem.sentence(word_count: 10)}
    end
end