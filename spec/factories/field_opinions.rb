# frozen_string_literal: true

FactoryBot.define do
  factory :field_opinion do
    body { Faker::Lorem.paragraph }
    is_positive { Faker::Boolean.boolean }
    user
    academy
    field_of_study

    trait :invalid do
      body { '' }
    end
  end
end
