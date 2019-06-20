require 'rails_helper'

RSpec.describe Academy, type: :model do
  let(:academy) { create(:academy) }

  describe 'validations' do
    subject { academy }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:academy_type) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
