FactoryBot.define do
    factory :category do
        title { Faker::Company.name }
    end
end