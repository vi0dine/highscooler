# frozen_string_literal: true

FactoryBot.define do
  factory :high_school do
    sequence(:name) { |n| "#{Faker::Educator.secondary_school} #{n}" }
    city { Faker::Address.city }
    school_type { Faker::Base.rand(2) }

    trait :invalid do
      name { nil }
    end

    factory :high_school_with_users do
      after :create do |high_school|
        create_list :user, 30, high_school: high_school
      end
    end
  end
end
