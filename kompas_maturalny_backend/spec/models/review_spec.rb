# == Schema Information
#
# Table name: reviews
#
#  id              :bigint           not null, primary key
#  body            :text
#  rate            :integer
#  reviewable_type :string
#  title           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  reviewable_id   :bigint
#  user_id         :bigint
#
# Indexes
#
#  index_reviews_on_reviewable_type_and_reviewable_id  (reviewable_type,reviewable_id)
#  index_reviews_on_user_id                            (user_id)
#  index_reviews_on_user_id_and_reviewable_id          (user_id,reviewable_id) UNIQUE
#

require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should have_db_column(:reviewable_id).of_type(:integer) }
  it { should have_db_column(:reviewable_type).of_type(:string) }

  describe 'fields' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:rate) }
    it { should validate_inclusion_of(:rate).in_range(0..5) }
  end

  describe 'associations' do
    it { should belong_to(:reviewable) }
    it { should belong_to(:user) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:reviewable_id) }
  end
end
