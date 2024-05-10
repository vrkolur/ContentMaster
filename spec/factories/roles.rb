FactoryBot.define do
    factory :role do
        title { Faker::Company.name }
    end
end