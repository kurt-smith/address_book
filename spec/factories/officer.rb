# frozen_string_literal: true

FactoryBot.define do
  factory :officer do
    company

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    occupation { Faker::Job.title }

    trait :with_residence do
      residence { Faker::Address.country }
    end

    trait :with_appointed_on do
      appointed_on { Faker::Date.backward(365) }
    end
  end
end
