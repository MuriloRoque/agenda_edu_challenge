FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password '123456'
    password_confirmation '123456'

    trait :invalid_email do
      email 'email'
    end

    trait :master do
      permission 1
    end
  end
end
