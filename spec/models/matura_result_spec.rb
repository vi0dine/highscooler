require 'rails_helper'

RSpec.describe MaturaResult, type: :model do
  let(:matura_result) { create(:matura_result) }
  let(:matura_result_no_level) { build(:matura_result, level: nil) }
  let(:matura_result_no_result) { build(:matura_result, result: nil) }

  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:result) }

  it 'should create valid matura result with all fields' do
    expect(matura_result.level).to eq('basic')
    expect(matura_result.result).to eq(99)
    expect(matura_result.matura_subject.name).to eq('Chemia')
    expect(matura_result.user.username).to eq('John123') 
  end

  it 'should be invalid when level is null' do
    expect(matura_result_no_level).to_not be_valid
  end

  it 'should be invalid when result is null' do
    expect(matura_result_no_level).to_not be_valid
  end

  it { should belong_to(:user) }
  it { should belong_to(:matura_subject) }
end
