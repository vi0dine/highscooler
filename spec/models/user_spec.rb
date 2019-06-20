require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user_with_results) { create(:user_with_results) }
  let(:user_with_interests) { create(:user_with_interests) }

  describe 'validations' do
    subject { user }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:encrypted_password) }
    it { should validate_presence_of(:account_type) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  it { should accept_nested_attributes_for(:matura_results) }
  it { should accept_nested_attributes_for(:study_interests) }

  it { should have_many(:matura_results) }

  it { should belong_to(:high_school) }
  it 'should belongs to one highschool' do
    expect(user.high_school).to be_kind_of(HighSchool)
  end

  it { should have_many(:field_of_studies).through(:study_interests) }
  it 'should have fields of studies' do
    expect(user_with_interests.field_of_studies.count).to eq(3)
    expect(user_with_interests.field_of_studies.first.name).to be_kind_of(String)
  end

  it 'should have hashed password' do
    expect(user.valid_password?('123456')).to be_truthy
  end
end
