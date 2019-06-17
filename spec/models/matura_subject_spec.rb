require 'rails_helper'

RSpec.describe MaturaSubject, type: :model do
  let(:matura_subject) { create(:matura_subject) }
  let(:matura_subject_no_name) { build(:matura_subject, name: nil) }
  let(:matura_subject_no_type) { build(:matura_subject, subject_type: nil) }

  it 'should create MaturaSubject with all data' do
    expect(matura_subject.name).to eq('Chemia')
    expect(matura_subject.subject_type).to eq('sciences')
  end

  it { should validate_presence_of(:name) }
  it 'should be invalid when name is null' do
    expect(matura_subject_no_name).to_not be_valid
  end

  it { should validate_presence_of(:subject_type) }
  it 'should be invalid when subject type is null' do
    expect(matura_subject_no_type).to_not be_valid
  end

  it { should validate_uniqueness_of(:name).case_insensitive }
end
