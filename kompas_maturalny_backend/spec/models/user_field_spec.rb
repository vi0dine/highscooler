# == Schema Information
#
# Table name: user_fields
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  field_of_study_id :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_user_fields_on_field_of_study_id              (field_of_study_id)
#  index_user_fields_on_user_id                        (user_id)
#  index_user_fields_on_user_id_and_field_of_study_id  (user_id,field_of_study_id) UNIQUE
#

require 'rails_helper'

RSpec.describe UserField, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:field_of_study) }
    it { should validate_uniqueness_of(:field_of_study_id).scoped_to(:user_id) }
  end
end
