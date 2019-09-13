# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudyInterest, type: :model do
  let(:study_interest) { create(:study_interest) }

  context 'validations' do
    it { should belong_to(:user) }
    it { should belong_to(:field_of_study) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:field_of_study_id) }
  end
end
