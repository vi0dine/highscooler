# frozen_string_literal: true

FactoryBot.define do
  factory :field_of_study do
    sequence(:name) { |n| "#{Faker::Educator.course_name} #{n}" }
    field_type { Faker::Base.rand(17) }

    factory :field_of_study_with_interests do
      after :create do |field_of_study|
        create_list :study_interest, 3, field_of_study: field_of_study
      end
    end

    factory :field_of_study_with_details do
      after :create do |field_of_study|
        create_list :field_detail, 3, field_of_study: field_of_study
      end
    end
  end
end
