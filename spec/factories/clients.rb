FactoryBot.define do
    factory :client do
        name { Faker::Company.name }
        sub_domain {Faker::Company.name }
        is_active {true}
    end
end