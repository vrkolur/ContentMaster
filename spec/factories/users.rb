FactoryBot.define do
    factory :user do
        name { Faker::Company.name }
        email {Faker::Internet.email}
        password {Faker::Internet.password(min_length: 8)}
        role_id {create(:role).id}
    end
end