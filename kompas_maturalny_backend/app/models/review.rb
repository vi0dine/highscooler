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

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  validates :user_id,
            uniqueness: { scope: :reviewable_id }

  validates :title,
            presence: true
  validates :body,
            presence: true
  validates :rate,
            presence: true,
            inclusion: { in: 0..5 }

  def self.academy
    self.reviewable.academy
  end
end
