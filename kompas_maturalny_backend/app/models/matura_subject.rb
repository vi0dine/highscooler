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

class MaturaSubject < ApplicationRecord
  has_many :matura_results

  enum subject_type: %i[humanities sciences others]

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :subject_type,
            presence: true
end
