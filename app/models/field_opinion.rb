# frozen_string_literal: true

class FieldOpinion < ApplicationRecord
  validates :body, presence: true
  validates_inclusion_of :is_positive, in: [true, false]
  validates_uniqueness_of :user_id, scope: %i[academy_id field_of_study_id]
  belongs_to :user
  belongs_to :field_of_study
  belongs_to :academy
end
