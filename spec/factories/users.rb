# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{Faker::Internet.email}_#{n}" }
    sequence(:username) { |n| "#{Faker::Internet.username}_#{n}" }
    password { Faker::Internet.password }
    city { Faker::Address.city }
    date_of_birth { Faker::Date.backward }
    gender { Faker::Base.rand(1) }
    account_type { Faker::Base.rand(4) }
    date_of_matura { Faker::Date.backward }
    high_school

    factory :user_with_interests do
      after :create do |user|
        create_list :study_interest, 3, user: user
      end
    end

    factory :user_with_results do
      after :create do |user|
        create_list :matura_result, 5, user: user
      end
    end
  end
end
