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

require 'rails_helper'

RSpec.describe MaturaSubject, type: :model do
  describe 'fields' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:level) }
    it { should validate_presence_of(:subject_type) }
    it { should define_enum_for(:subject_type).with_values(%i[humanities sciences others]) }
    it { should define_enum_for(:level).with_values(%i[basic advanced]) }
  end

  describe 'associations' do
    it { should have_many(:matura_results) }
  end
end
