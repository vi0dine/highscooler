# == Schema Information
#
# Table name: matura_subjects
#
#  id           :bigint           not null, primary key
#  name         :string
#  subject_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :matura_subject do
    name { Faker::Educator.subject }
    subject_type { ['humanities', 'sciences', 'others'].sample }
  end
end
