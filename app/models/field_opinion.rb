# frozen_string_literal: true

class FieldOpinion < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :field_of_study
  belongs_to :academy
end
