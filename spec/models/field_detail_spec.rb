# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldDetail, type: :model do
  let(:field_detail) { create(:field_detail) }

  context 'with valid attributes' do
    it { should validate_presence_of(:recrutation_formula) }
    it {
      should validate_uniqueness_of(:field_of_study_id)
        .scoped_to(:academy_id)
    }
    it {
      should allow_value(
        "[(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)]+
        [(Fizyka_Pp*0.2)|(Fizyka_Pr*0.4)]"
      )
        .for(:recrutation_formula)
    }

    it { should_not allow_value('Bio*0.5+Ang*1.3+Fiz**0.1').for(:recrutation_formula) }
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
