# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MaturaResult, type: :model do
  let(:matura_result) { create(:matura_result) }

  context 'validations' do
    it { should belong_to(:user) }
    it { should belong_to(:matura_subject) }
    it { should validate_presence_of(:level) }
    it { should define_enum_for(:level).with_values(%i[basic advanced]) }
    it { should validate_presence_of(:result) }
    it { should validate_inclusion_of(:result).in_range(0..100) }
  end

  context 'without result value' do
    let(:matura_result_no_result) { build(:matura_result, result: nil) }
    it { expect(matura_result_no_result).to_not be_valid }
  end

  context 'without level value' do
    let(:matura_result_no_level) { build(:matura_result, level: nil) }
    it { expect(matura_result_no_level).to_not be_valid }
  end

  context 'model methods' do
    let(:basic_subject) { create(:matura_subject, name: 'Matematyka') }
    let(:basic_matura_result) {
      create(:matura_result, level: 'basic', matura_subject: basic_subject)
    }
    it { expect(basic_matura_result.basic?).to be true }
    it { expect(basic_matura_result.advanced?).to be false }
    it {
      expect(basic_matura_result.basic_subject?('Matematyka_Pp')).to be true
    }
    it {
      expect(basic_matura_result.basic_subject?('Matematyka_Pr')).to be false
    }

    let(:advanced_subject) { create(:matura_subject, name: 'Chemia') }
    let(:advanced_matura_result) {
      create(:matura_result, level: 'advanced', matura_subject: advanced_subject)
    }
    it { expect(advanced_matura_result.basic?).to be false }
    it { expect(advanced_matura_result.advanced?).to be true }
    it {
      expect(advanced_matura_result.advanced_subject?('Chemia_Pp')).to be false
    }
    it {
      expect(advanced_matura_result.advanced_subject?('Chemia_Pr')).to be true
    }
  end
end
