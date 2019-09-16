# frozen_string_literal: true

FactoryBot.define do
  factory :academy_opinion do
    body { Faker::Lorem.paragraph }
    is_positive { Faker::Boolean.boolean }
    user
    academy
  end
end
