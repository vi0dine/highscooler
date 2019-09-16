# frozen_string_literal: true

class StudyInterest < ApplicationRecord
  belongs_to :field_of_study
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :field_of_study_id
end
