# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MaturaSubject, type: :model do
  let(:matura_subject) { create(:matura_subject) }

  context 'validations' do
    it { should have_many(:matura_results) } 
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:subject_type) }
    it {
      should define_enum_for(:subject_type)
        .with_values(%i[humanities sciences others])
    }
  end

  context 'with no name' do
    let(:matura_subject_no_name) { build(:matura_subject, name: nil) }
    it { expect(matura_subject_no_name).to_not be_valid }
  end

  context 'with no type' do
    let(:matura_subject_no_type) { build(:matura_subject, subject_type: nil) }
    it { expect(matura_subject_no_type).to_not be_valid }
  end
end
