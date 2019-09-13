# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldDetail, type: :model do
  let(:field_detail) { create(:field_detail) }

  context 'validations' do
    it { should validate_presence_of(:recrutation_formula) }
    it {
      should validate_uniqueness_of(:field_of_study_id)
        .scoped_to(:academy_id)
    }
    it { should belong_to(:academy) }
    it { should belong_to(:field_of_study) }
    it { expect(field_detail.name).to eq(field_detail.field_of_study.name) }
  end

  context 'with interested users' do
    let(:field_detail_with_interesteds) { create(:field_detail_with_interesteds) }
    it { should have_many(:interesteds) }
    it { expect(field_detail_with_interesteds.interesteds.count).to eq(10) }
    it { should have_many(:users).through(:interesteds) }
    it { expect(field_detail_with_interesteds.users.count).to eq(10) }
  end
end
