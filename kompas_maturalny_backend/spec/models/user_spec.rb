# == Schema Information
#
# Table name: users
#
#  id                              :bigint           not null, primary key
#  authentication_token            :text
#  authentication_token_created_at :datetime
#  city                            :string
#  date_of_birth                   :date
#  date_of_matura                  :date
#  email                           :string           default(""), not null
#  encrypted_password              :string           default(""), not null
#  gender                          :integer
#  remember_created_at             :datetime
#  reset_password_sent_at          :datetime
#  reset_password_token            :string
#  role                            :integer
#  username                        :string
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#
# Indexes
#
#  index_users_on_authentication_token  (authentication_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "fields" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_presence_of(:encrypted_password) }
    it { should validate_presence_of(:role) }
    it {
      should define_enum_for(:role)
                 .with_values(%i[schoolboy student partner admin])
    }
    it {
      should define_enum_for(:gender)
                 .with_values(%i[female male])
    }
  end

  describe "callbacks" do
    it "creates an auth token before saving if one does not exist" do
      user = build(:user)
      expect(user.authentication_token).to be_blank

      user.save

      expect(user.reload.authentication_token).to_not be_blank
    end
  end
end
