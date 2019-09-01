# frozen_string_literal: true

FactoryBot.define do
  factory :academy do
    sequence(:name) { |n| "University no #{n}"}
    city { Faker::Address.city }
    academy_type { Faker::Base.rand(6) }
    after :create do |academy|
      create_list :academy_opinion, 15, academy: academy
    end

    factory :academy_with_field_details do
      after :create do |academy|
        create_list :field_detail, 50, academy: academy
      end
    end
  end
end
