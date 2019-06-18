require 'rails_helper'

RSpec.describe HighSchool, type: :model do
  let(:high_school) { create(:high_school) }
  let(:high_school_with_users) { create(:high_school_with_users) }

  describe 'validations' do
    subject { high_school_with_users }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:school_type) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should have_many(:users) }
  end

  it 'should have some users associated' do
    expect(high_school_with_users.users.count).to eq(10)  
  end
end
