# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'with valid attributes' do
    subject { user }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_presence_of(:encrypted_password) }
    it { should validate_presence_of(:account_type) }
    it {
      should define_enum_for(:account_type)
        .with_values(%i[schoolboy student partner admin])
    }
    it {
      should define_enum_for(:gender)
        .with_values(%i[female male not_specified])
    }
    it { should accept_nested_attributes_for(:matura_results) }
    it { should accept_nested_attributes_for(:study_interests) }
    it { should have_many(:matura_results) }
    it { should have_many(:study_interests) }
    it { should belong_to(:high_school).optional }
    it { should have_many(:field_of_studies).through(:study_interests) }
    it { should have_many(:matura_subjects).through(:matura_results) }
    it { should have_many(:field_details).through(:field_of_studies) }
  end

  context 'with some fields of studies' do
    let(:user_with_interests) { create(:user_with_interests) }
    it { expect(user_with_interests.field_of_studies.count).to eq(3) }
  end

  context 'with some matura results' do
    let(:user_with_results) { create(:user_with_results) }
    it { expect(user_with_results.matura_results.count).to eq(5) }
  end

  context 'when called model methods' do
    let(:user_with_interests) { create(:user_with_interests) }
    let(:admin_user) { create(:user, account_type: 'admin') }
    let(:schoolboy_user) { create(:user, account_type: 'schoolboy') }
    let(:user_interested_in_physics) { create(:user_interested_in_physics) }
    let(:physics) { create(:field_of_study, name: 'Fizyka') }
    let(:other_field) { create(:field_of_study) }
    let(:uwr) { create(:academy, name: 'Uniwersytet Wrocławski') }
    let(:other_academy) { create(:academy) }
    let(:student_of_physics_at_uwr) {
      create(:user, account_type: 'student',
                    field_of_study: physics, academy: uwr)
    }

    it { expect(admin_user.admin?).to be true }
    it { expect(admin_user.schoolboy?).to be false }
    it { expect(schoolboy_user.admin?).to be false }
    it { expect(schoolboy_user.schoolboy?).to be true }
    it {
      expect(user_interested_in_physics.interested_in_field?('Fizyka')).to be true
    }
    it { expect(student_of_physics_at_uwr.student_of_academy?(uwr)).to be true }
    it { expect(student_of_physics_at_uwr.student_of_academy?(other_academy)).to be false }
    it { expect(student_of_physics_at_uwr.student_of_field?(physics)).to be true }
    it { expect(student_of_physics_at_uwr.student_of_field?(other_field)).to be false }
    it { expect(user_with_interests.formulas).to be }
    it { expect(user_with_interests.formulas).to all be_a(String) }
  end
end
