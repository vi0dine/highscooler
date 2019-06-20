FactoryBot.define do
  factory :field_detail do
    students_limit { Faker::Base.rand(400) }
    minimal_points { Faker::Base.rand(600) }
    recrutation_formula { '2*M + 1*F + 0.5*Jo + 0.5*Jp' }
    academy
    field_of_study
  end
end
