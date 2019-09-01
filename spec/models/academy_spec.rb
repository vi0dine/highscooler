# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Academy, type: :model do
  let(:academy) { create(:academy) }
  let(:academy_with_field_details) { create(:academy_with_field_details) }
  let(:academy_with_students) { create(:academy_with_students) }

  context 'academy without fields' do
    subject { academy }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:academy_type) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should have_many(:academy_opinions) }
    it { expect(%i[university polytechnic music_academy medical_academy art_academy other]).to include(academy.academy_type.to_sym) }
  end

  context 'academy with fields' do
    subject { academy_with_field_details }
    let(:field) { academy_with_field_details.field_of_studies.sample }
    it { should have_many(:field_details) }
    it { should have_many(:academy_opinions) }
    it { should have_many(:field_of_studies).through(:field_details) }
    it { expect(academy_with_field_details.interested_users_count).to eq(academy_with_field_details.field_of_studies.sum { |f| f.field_details.first.users.count }) }
    it { expect(academy_with_field_details.interested_users_count_of_field(field)).to eq(academy_with_field_details.field_details.select { |f| f.field_of_study == field }.first.users.count) }
  end

  context 'academy with students' do
    subject { academy_with_students }
    it { should have_many(:users) }
    it { should have_many(:field_opinions).through(:users) }
    it { should have_many(:academy_opinions) }
    it { expect(academy_with_students.users).to all(have_attributes(account_type: 'student')) }
  end
end
