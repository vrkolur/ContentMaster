FactoryBot.define do
    factory :client do
        name { Faker::Name.first_name }
        sub_domain { Faker::Name.first_name }
        is_active {true}
    end
end