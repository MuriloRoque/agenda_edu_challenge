FactoryBot.define do
  factory :message do
    title {Faker::Name.name}
    content 'Lorem ipsum'
    from { FactoryBot.create(:user).id}
    to { FactoryBot.create(:user).id}

    trait :no_from do
      from nil
    end

    trait :no_to do
      to nil
    end

    trait :read do
      status 1
    end

    trait :archived do
      status 2
    end
  end
end
