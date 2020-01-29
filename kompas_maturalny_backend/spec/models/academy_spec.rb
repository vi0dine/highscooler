# == Schema Information
#
# Table name: academies
#
#  id          :bigint           not null, primary key
#  city        :string
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Academy, type: :model do
  describe 'fields' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:city) }
  end

  describe 'associations' do
    it { should have_many(:academy_fields) }
    it { should have_many(:field_of_studies).through(:academy_fields) }
  end
end
