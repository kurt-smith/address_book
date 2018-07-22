# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    address_line_1 { Faker::Address.street_name }
    country { Faker::Address.country }
    region { Faker::Address.state }
    locality { Faker::Address.city }
    premises { Faker::Address.building_number }
    postal_code { Faker::Address.postcode }

    trait :with_address_line_2 do
      address_line_2 { Faker::Address.secondary_address }
    end
  end
end
