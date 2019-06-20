require 'rails_helper'

RSpec.describe FieldOfStudy, type: :model do
  let(:field_of_study) { create(:field_of_study) }
  let(:field_of_study_with_interests) { create(:field_of_study_with_interests) }
  let(:field_of_study_no_name) { build(:field_of_study, name: nil) }
  let(:field_of_study_no_type) { build(:field_of_study, field_type: nil) }

  it 'should initialize FieldOfStudy with name and type' do
    expect(field_of_study.name).to be_kind_of(String)
    expect(field_of_study.field_type).to be_kind_of(String)
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
  it 'should has many study interests' do
    expect(field_of_study_with_interests.study_interests.count).to eq(3)
  end

  it { should have_many(:users).through(:study_interests) }
  it 'should has many users via study interests' do
    expect(field_of_study_with_interests.users.count).to eq(3)
  end

  it { should validate_uniqueness_of(:name).case_insensitive }
end
