FactoryBot.define do
  factory :matura_subject do
    name { Faker::Educator.subject }
    subject_type { 1 }
  end
end
