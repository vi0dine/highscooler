require 'rails_helper'

RSpec.describe FieldOfStudy, type: :model do
  describe 'field of study with details' do
    let(:field_of_study_full) { create(:field_of_study) }
    let(:field_of_study_no_name) { build(:field_of_study, name: nil) }
    let(:field_of_study_no_type) { build(:field_of_study, field_type: nil) }

    it 'should initialize FieldOfStudy with name and type' do
      expect(field_of_study_full.name).to eq('Lekarski')
      expect(field_of_study_full.field_type).to eq(4)
    end

    it { should validate_presence_of(:name) }
    it 'cant be valid without name' do
      expect(field_of_study_no_name).to_not be_valid
    end

    it { should validate_presence_of(:field_type) }
    it 'cant be valid without field type' do
      expect(field_of_study_no_type).to_not be_valid
    end

    it { should have_many(:study_interests) }
    it 'should has many study interests'

    it { should have_many(:users).through(:study_interests) }
    it 'should has many users via study interests'

    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
