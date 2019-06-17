FactoryBot.define do
  factory :study_interest do
    user
    association :field_of_study, factory: :field_of_study
  end
end
