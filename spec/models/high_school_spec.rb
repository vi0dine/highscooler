# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HighSchool, type: :model do
  let(:high_school) { create(:high_school) }

  context 'with valid attributes' do
    subject { high_school }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it { should validate_presence_of(:school_type) }
    it {
      should define_enum_for(:school_type)
        .with_values(%i[general technological other])
    }
  end

  context 'with users associated' do
    let(:high_school_with_users) { create(:high_school_with_users) }
    it { should have_many(:users) }
    it { expect(high_school_with_users.users.count).to eq(30) }
  end
end
