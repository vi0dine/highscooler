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

FactoryBot.define do
  factory :review do
    title { Faker::Quote.singular_siegler }
    body { Faker::Lorem.paragraph(sentence_count: 3) }
    rate { Faker::Base.rand_in_range(0, 5) }
    user
    reviewable { association(:academy_field) }
  end
end
