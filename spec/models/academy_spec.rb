# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Academy, type: :model do
  let(:academy) { create(:academy) }

  context 'validations' do
    subject { academy }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:academy_type) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it {
      should define_enum_for(:academy_type)
        .with_values(%i[university polytechnic music_academy
                        medical_academy art_academy other])
    }
  end

  context 'with opinions' do
    let(:academy_with_opinions) { create(:academy_with_opinions) }
    it { should have_many(:academy_opinions) }
  end

  context 'with fields' do
    let(:academy_with_field_details) { create(:academy_with_field_details) }
    let(:field) { academy_with_field_details.field_of_studies.sample }
    it { should have_many(:field_details) }
    it { should have_many(:field_of_studies).through(:field_details) }
  end

  context 'with students' do
    let(:academy_with_students) { create(:academy_with_students) }
    it { should have_many(:users) }
    it { should have_many(:field_opinions).through(:users) }
    it {
      expect(academy_with_students.users)
        .to all(have_attributes(account_type: 'student'))
    }
  end
end
