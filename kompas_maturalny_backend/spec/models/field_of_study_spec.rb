# == Schema Information
#
# Table name: field_of_studies
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe FieldOfStudy, type: :model do
  describe 'fields' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should have_many(:academy_fields) }
    it { should have_many(:academies).through(:academy_fields) }
    it { should have_many(:reviews).through(:academy_fields) }
  end
end
