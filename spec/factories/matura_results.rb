FactoryBot.define do
  factory :matura_result do
    level { 0 }
    result { 99 }
    user
    matura_subject
  end
end
