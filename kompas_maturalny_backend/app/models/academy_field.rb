require 'recruitment_formula_calculator'

# == Schema Information
#
# Table name: academy_fields
#
#  id                  :bigint           not null, primary key
#  recruitment_formula :string
#  students_limit      :integer
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

class AcademyField < ApplicationRecord
  include Reviewable

  belongs_to :academy
  belongs_to :field_of_study

  validates :academy_id,
            uniqueness: { scope: :field_of_study_id }

  validates :recruitment_formula,
            presence: true
            #format: { with: /\[\(.*\)\]/, on: :create, message: "Błędny format formuły." }

  def calculate_recruitment_points_for(user)
    RecruitmentFormulaCalculator::Formula.new(self.recruitment_formula).calculate(user)
  end

  def subjects
    RecruitmentFormulaCalculator::Formula.new(self.recruitment_formula).get_subjects
  end
end
