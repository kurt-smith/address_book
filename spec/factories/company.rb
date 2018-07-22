# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    number { Faker::Company.swedish_organisation_number&.to_i }
    active { Faker::Boolean.boolean }
    description { Faker::Company.catch_phrase }

    trait :with_officers do
      transient do
        count 5
      end

      after(:create) do |company, evaluator|
        evaluator.count.times { create(:officer, company: company) }
      end
    end
  end
end
