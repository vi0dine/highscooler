require 'rails_helper'

RSpec.describe StudyInterest, type: :model do
  let(:study_interest) { create(:study_interest) }

  it 'should have user_id and field_of_study_id' do
    expect(study_interest.user.username).to be_kind_of(String)
    expect(study_interest.field_of_study.name).to be_kind_of(String)
  end

  it { should belong_to(:user) }
  it { should belong_to(:field_of_study) }
end
