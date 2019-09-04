# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldOfStudy, type: :model do
  let(:field_of_study) { create(:field_of_study) }
  let(:field_of_study_with_interests) { create(:field_of_study_with_interests) }
  let(:field_of_study_with_details) { create(:field_of_study_with_details) }

  describe 'with all attributes' do
    subject { field_of_study }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:field_type) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'with field details' do
    subject { field_of_study_with_details }
    it { should have_many(:field_details) }
    it { should have_many(:academies).through(:field_details) }
    it { should have_many(:interesteds).through(:field_details) } 
    it { expect(field_of_study_with_details.interested_users_count).to eq(field_of_study_with_details.field_details.sum(&:interested_users_count)) }
  end

  describe 'with study interests' do
    subject { field_of_study_with_interests }
    it { should have_many(:study_interests) }
    it { should have_many(:users).through(:study_interests) }
  end
end
