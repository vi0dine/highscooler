# == Schema Information
#
# Table name: matura_results
#
#  id                :bigint           not null, primary key
#  result            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  matura_subject_id :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_matura_results_on_matura_subject_id  (matura_subject_id)
#  index_matura_results_on_user_id            (user_id)
#

require 'rails_helper'

RSpec.describe MaturaResult, type: :model do
  describe 'fields' do
    it { should validate_presence_of(:result) }
    it { should validate_inclusion_of(:result).in_range(0..100) }
    it { should belong_to(:user) }
    it { should belong_to(:matura_subject) }
  end
end
