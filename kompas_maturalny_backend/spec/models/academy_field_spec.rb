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

require 'rails_helper'
require "models/concerns/reviewable_spec"

RSpec.describe AcademyField, type: :model do
  describe 'fields' do
    it { should belong_to(:academy) }
    it { should belong_to(:field_of_study) }
    it { should validate_uniqueness_of(:academy_id).scoped_to(:field_of_study_id) }
    it { should validate_presence_of(:recruitment_formula) }
  end

  describe 'associations' do
    it_behaves_like "reviewable"
    it { should have_many(:reviews) }
  end
end
