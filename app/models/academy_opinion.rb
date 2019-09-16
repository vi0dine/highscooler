# frozen_string_literal: true

class AcademyOpinion < ApplicationRecord
  validates :body, presence: true
  validates_inclusion_of :is_positive, in: [true, false]
  validates_uniqueness_of :user_id, scope: :academy_id
  belongs_to :user
  belongs_to :academy
end
