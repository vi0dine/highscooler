require 'rails_helper'

RSpec.describe Academy, type: :model do
  let(:academy) { create(:academy) }
  let(:academy_with_field_details) { create(:academy_with_field_details) }

  describe 'basic validations' do
    subject { academy }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:academy_type) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should have_many(:academy_opinions) }
    it { expect(%i[university polytechnic music_academy medical_academy art_academy other]).to include(academy.academy_type.to_sym) }
  end

  describe 'with details validations' do
    subject { academy_with_field_details }
    it { should have_many(:field_details) }
    it { should have_many(:academy_opinions) }
    it { should have_many(:field_of_studies).through(:field_details) }
  end
end
