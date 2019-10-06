# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldOfStudy, type: :model do
  let(:field_of_study) { create(:field_of_study) }

  context 'with valid attributes' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:field_type) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  context 'with field details' do
    let(:field_of_study_with_details) { create(:field_of_study_with_details) }
    it { should have_many(:field_details) }
    it { should have_many(:academies).through(:field_details) }
    it { should have_many(:interesteds).through(:field_details) }
  end

  context 'with study interests' do
    let(:field_of_study_with_interests) { create(:field_of_study_with_interests) }
    it { should have_many(:study_interests) }
    it { should have_many(:users).through(:study_interests) }
  end
end
