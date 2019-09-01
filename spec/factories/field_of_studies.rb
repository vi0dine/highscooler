FactoryBot.define do
  factory :field_of_study do
    name { Faker::Educator.course_name }
    field_type { 4 }

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