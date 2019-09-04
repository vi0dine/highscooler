# frozen_string_literal: true

FactoryBot.define do
  factory :field_detail do
    students_limit { Faker::Base.rand(400) }
    minimal_points { Faker::Base.rand(600) }
    recrutation_formula { '[(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1)]+[(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1)]+[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)]' }
    academy
    field_of_study

    factory :field_detail_with_interesteds do
      after :create do |field_detail|
        create_list :interested, 10, field_detail: field_detail
      end
    end
  end
end
