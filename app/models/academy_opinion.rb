# frozen_string_literal: true

class AcademyOpinion < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :academy
end
