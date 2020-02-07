# == Schema Information
#
# Table name: matura_subjects
#
#  id           :bigint           not null, primary key
#  level        :integer
#  name         :string
#  subject_type :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :matura_subject do
    sequence(:name) { |n| "#{Faker::Educator.subject} #{n}" }
    level { ['basic', 'advanced'].sample }
    subject_type { ['humanities', 'sciences', 'others'].sample }
  end
end
