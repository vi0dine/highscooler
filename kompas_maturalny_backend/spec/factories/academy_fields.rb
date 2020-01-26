# == Schema Information
#
# Table name: academy_fields
#
#  id                  :bigint           not null, primary key
#  recruitment_formula :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  academy_id          :bigint
#  field_of_study_id   :bigint
#
# Indexes
#
#  index_academy_fields_on_academy_id                        (academy_id)
#  index_academy_fields_on_academy_id_and_field_of_study_id  (academy_id,field_of_study_id) UNIQUE
#  index_academy_fields_on_field_of_study_id                 (field_of_study_id)
#

FactoryBot.define do
  factory :academy_field do
    academy
    field_of_study
    recruitment_formula { "[(chemia_pr*2)|(biologia_pr*2)]+[(fizyka_pr*2)|(geografia_pr*2)]+[(angielski_pp*0.2)|(angielski_pr*0.4)|(francuski_pp*0.2)|(francuski_pr*0.4)|(niemiecki_pp*0.2)|(niemiecki_pr*0.4)]" }
  end
end
