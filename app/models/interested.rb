# frozen_string_literal: true

class Interested < ApplicationRecord
  belongs_to :field_detail
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :field_detail_id
  validates :user_id, :field_detail_id, presence: true

  after_create :increment_academy_counter_cache
  after_create :increment_field_of_study_counter_cache

  def increment_academy_counter_cache
    Academy.increment_counter(:interesteds_count, field_detail.academy_id)
  end

  def increment_field_of_study_counter_cache
    FieldOfStudy.increment_counter(:interesteds_count, field_detail.field_of_study_id)
  end
end
