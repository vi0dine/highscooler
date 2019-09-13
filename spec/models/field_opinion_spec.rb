# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldOpinion, type: :model do
  let(:opinion) { create(:field_opinion) }

  context 'with all attributes' do
    subject { opinion }
    it { should validate_presence_of(:body) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:academy_id, :field_of_study_id) }
    it { expect(opinion.is_positive).to be_in([true, false]) }
    it { should belong_to(:user) }
    it { should belong_to(:academy) }
    it { should belong_to(:field_of_study) }
  end
end
