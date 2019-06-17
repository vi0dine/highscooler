FactoryBot.define do
  factory :field_of_study do
    name { 'Lekarski' }
    field_type { 4 }
    after :create do |field_of_study|
      create_list :study_interest, 5, field_of_study: field_of_study
    end
  end
end