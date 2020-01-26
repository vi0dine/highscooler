# == Schema Information
#
# Table name: matura_results
#
#  id                :bigint           not null, primary key
#  result            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  matura_subject_id :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_matura_results_on_matura_subject_id  (matura_subject_id)
#  index_matura_results_on_user_id            (user_id)
#

FactoryBot.define do
  factory :matura_result do
    user
    subject
    result { Faker::Base.rand_in_range(0, 100) }
    level { ['basic', 'advanced'].sample }
  end
end
