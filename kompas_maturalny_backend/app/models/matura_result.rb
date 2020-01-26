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

class MaturaResult < ApplicationRecord
  belongs_to :user
  belongs_to :matura_subject

  validates :result,
            presence: true,
            numericality: { only_integer: true },
            inclusion: { in: 0...100 }
end
