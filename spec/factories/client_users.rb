FactoryBot.define do
    factory :client_user do
        user_id { create(:user).id }
        client_id { create(:client).id }
    end
end